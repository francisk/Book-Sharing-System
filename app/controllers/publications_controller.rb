require 'net/http'
require 'json'

class PublicationsController < ApplicationController

  @@apikey = "0151de22e015f5a903f59a68a041e0fb"
  @@PAGENO = 5
  
  def search
    @publications = Publication.search(:isbn_or_title_or_additional_attributes_value_contains => params[:keyword]).group(:isbn).paginate(:page => params[:page], :per_page => @@PAGENO, :order => 'created_at desc')
        
    render :action => :index
  end
  
  # GET /publications
  # GET /publications.json
  def index
    @publications = Publication.group(:isbn).paginate(:page => params[:page], :per_page => @@PAGENO, :order => 'created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @publications }
    end
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    @publication = Publication.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @publication }
    end
  end

  # GET /publications/new
  # GET /publications/new.json
  def new
    @publication = Publication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @publication }
    end
  end

  # GET /publications/1/edit
  def edit
    @publication = Publication.find(params[:id])
  end

  # POST /publications
  # POST /publications.json
  def create
    Publication.transaction do
      @publication = Publication.new(params[:publication])
      @publication.state = Publication::STATE_NOT_AUTH
      @publication.save
    
      @publication.contributor = User.first
      isbn = params[:publication]["isbn"]
      if isbn != ""
        fillBookInfo(isbn, @publication)
      end
    end

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, :notice => 'Publication was successfully created.' }
        format.json { render :json => @publication, :status => :created, :location => @publication }
      else
        format.html { render :action => "new" }
        format.json { render :json => @publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /publications/1
  # PUT /publications/1.json
  def update
    @publication = Publication.find(params[:id])

    respond_to do |format|
      if @publication.update_attributes(params[:publication])
        format.html { redirect_to @publication, :notice => 'Publication was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to publications_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Douban api
  def fillBookInfo(isbn, publication)
    bookInfo = ActiveSupport::JSON.decode(queryJson(isbn))
    publication.title = bookInfo["title"]["$t"]
    publication.summary = bookInfo["summary"]["$t"]
    
    fillLinks(bookInfo["link"], publication)
    fillAttributes(bookInfo["db:attribute"], publication)
    fillTags(bookInfo["db:tag"], publication)
  end
  
  def queryJson(isbn)
    url = URI.parse('http://api.douban.com/book/subject/isbn/' + isbn)
    # Net::HTTP::Proxy("10.1.159.48", "808", "javajava", "javajava").start(url.host, url.port) do |http|
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Get.new(url.path + "?apikey=" + @@apikey + "&alt=json")
      json = http.request(req).body
    end
  end
  
  def fillAttributes(attributes, publication)
    attributes.each do |attribute|
      if attribute != nil
        publication.additional_attributes.create!(:name => attribute["@name"], :value => attribute["$t"])
      end
    end
  end
  
  def fillTags(tags, publication)
    tags.each do |tag|
      if tag != nil
        tagName = tag["@name"]
        publication.tags.create!(:name => tagName)
      end
    end
  end
  
  def fillLinks(links, publication)
      links.each do |link|
        if link != nil
          rel = link["@rel"]
          href = link["@href"]
          if rel == "image"
            publication.cover = href
          end
          if rel == "alternate"
            publication.doubanURL = href
          end
        end
     end 
  end
end
