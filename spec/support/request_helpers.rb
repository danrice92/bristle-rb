def response_body
  JSON.parse(response.body).with_indifferent_access
end

def email_body email
  email.html_part.body.raw_source
end
