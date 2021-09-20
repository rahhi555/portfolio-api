D = Steep::Diagnostic

target :app do
  signature 'sig'

  check 'app'

  repo_path 'vendor/rbs/gem_rbs_collection/gems'

  library 'pathname'
  library 'logger'
  library 'mutex_m'
  library 'date'
  library 'monitor'
  library 'singleton'
  library 'tsort'
  library 'railties'
  library 'net-http'
  library 'forwardable'

  library 'actionpack'
  library 'actionview'
  library 'activejob'
  library 'activemodel'
  library 'activerecord'
  library 'activestorage'
  library 'activesupport'
  library 'ast'
  library 'httparty'
  library 'httpclient'
  library 'listen'
  library 'nokogiri'
  library 'parallel'
  library 'rack'
  library 'railties'
  library 'redis'
  library 'regexp_trie'
  library 'retryable'
  library 'scanf'
  library 'ulid'

  configure_code_diagnostics do |hash|
    hash[D::Ruby::NoMethod] = :information
    hash[D::Ruby::UnexpectedPositionalArgument] = :information
    hash[D::Ruby::RequiredBlockMissing] = :information
    hash[D::Ruby::MethodDefinitionMissing] = :hint
  end
end
