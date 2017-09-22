class GoogleDomain
  USER_ID = "me"
  COLLECTION = "cloud"
  DOMAIN = "domain"
  OBJECT_TYPES = {
    photo: "photo",
    album: "album",
    video: "video",
    artcle: "article"
  }

  def initialize
  end

  def insert_photo(service, upload_path, display_name = "", content = "")
    media = Google::Apis::PlusDomainsV1::Media.new
    media.display_name = display_name
    medium = service.insert_medium(USER_ID, COLLECTION, media, upload_source: upload_path)
    medium_id = medium.id
    acl = Google::Apis::PlusDomainsV1::Acl.new(domain_restricted: true)
    items = Google::Apis::PlusDomainsV1::PlusDomainsAclentryResource.new(type: DOMAIN)
    acl.items = [items]
    attachment = Google::Apis::PlusDomainsV1::Activity::Object::Attachment.new
    attachment.object_type = OBJECT_TYPES[:photo]
    attachment.id = medium_id
    object = Google::Apis::PlusDomainsV1::Activity::Object.new
    object.content = content
    object.attachments = [attachment]
    activity = Google::Apis::PlusDomainsV1::Activity.new(access: acl, object: object)
    act = service.insert_activity(USER_ID, activity)
  end
end
