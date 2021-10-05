D = Steep::Diagnostic

target :app do
  signature 'sig'

  check 'app'

  configure_code_diagnostics do |hash|
    hash[D::Ruby::NoMethod] = :information
    hash[D::Ruby::UnexpectedPositionalArgument] = :information
    hash[D::Ruby::RequiredBlockMissing] = :information
    hash[D::Ruby::MethodDefinitionMissing] = :hint
  end
end
