D = Steep::Diagnostic

target :app do
  signature 'sig'

  check 'app'

  repo_path 'vendor/rbs/gem_rbs/gems'

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
  library 'activesupport'
  library 'ast'
  library 'chunky_png'
  library 'httparty'
  library 'listen'
  library 'protobuf'
  library 'rack'
  library 'redis'
  library 'regexp_trie'
  library 'retryable'
  library 'ulid'

  configure_code_diagnostics do |hash|
    hash[D::Ruby::NoMethod] = :information
    hash[D::Ruby::UnexpectedPositionalArgument] = :information
    hash[D::Ruby::RequiredBlockMissing] = :information
    hash[D::Ruby::MethodDefinitionMissing] = :hint
  end
end
