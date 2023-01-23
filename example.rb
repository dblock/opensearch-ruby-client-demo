# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

require 'rubygems'

require 'opensearch-aws-sigv4'
require 'aws-sigv4'

signer = Aws::Sigv4::Signer.new(
  service: ENV['SERVICE'] || 'es',
  region: ENV['AWS_REGION'] || 'us-east-1',
  access_key_id: ENV['AWS_ACCESS_KEY_ID'] || raise('Missing AWS_ACCESS_KEY_ID.'),
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || raise('Missing AWS_SECRET_ACCESS_KEY.'),
  session_token: ENV['AWS_SESSION_TOKEN']
)

client = OpenSearch::Aws::Sigv4Client.new({
  host: ENV['ENDPOINT'] || raise('Missing ENDPOINT.'),
  log: true
}, signer)

# TODO: remove when OpenSearch Serverless adds / API
case ENV['SERVICE'] || 'es'
when 'es'
  info = client.info
  puts info['version']['distribution'] + ': ' + info['version']['number']
end

# create an index
index = 'movies'
client.indices.create(index: index)

begin
  # index data
  document = { title: 'Moneyball', director: 'Bennett Miller', year: 2011 }
  client.index(index: index, body: document, id: '1')

  # wait for the document to index
  sleep(3)

  # search for the document
  results = client.search(body: { query: { match: { director: 'miller' } } })
  results['hits']['hits'].each do |hit|
    puts hit
  end

  # delete the document
  client.delete(index: index, id: '1')
ensure
  # delete the index
  client.indices.delete(index: index)
end
