# OpenSearch Ruby Client Demo

Makes requests to Amazon OpenSearch using the OpenSearch Ruby Client, specifically [opensearch-aws-sigv4](https://rubygems.org/gems/opensearch-aws-sigv4) released as part of (https://github.com/opensearch-project/opensearch-ruby/issues/71).

## Running

Create an OpenSearch domain in (AWS) which support IAM based AuthN/AuthZ.

```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
export AWS_REGION=

export OPENSEARCH_ENDPOINT=https://....us-west-2.es.amazonaws.com

bundle exec ruby example.rb
```

This will output the version of OpenSearch and a search result.

```
opensearch: 1.2.4
{"_index"=>"sample-index", "_type"=>"_doc", "_id"=>"1", "_score"=>0.2876821, "_source"=>{"first_name"=>"Bruce"}}
```

The code will create an index, add a document, then cleanup.

## License 

This project is licensed under the [Apache v2.0 License](LICENSE.txt).

## Copyright

Copyright OpenSearch Contributors. See [NOTICE](NOTICE.txt) for details.
