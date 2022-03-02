D = Steep::Diagnostic

target :app do
  signature 'sig'

  check 'app'

  repo_path '.gem_rbs_collection'

  library 'pathname'
  library 'logger'
  library 'mutex_m'
  library 'date'
  library 'monitor'
  library 'singleton'
  library 'tsort'

  library 'rack'

  library 'activesupport'
  library 'actionpack'
  library 'activejob'
  library 'activemodel'
  library 'actionview'
  library 'activerecord'
  library 'railties'

  configure_code_diagnostics do |hash|
    hash[D::Ruby::NoMethod] = :information
    hash[D::Ruby::UnexpectedPositionalArgument] = :information
    hash[D::Ruby::RequiredBlockMissing] = :information
    hash[D::Ruby::MethodDefinitionMissing] = :hint
  end
end
