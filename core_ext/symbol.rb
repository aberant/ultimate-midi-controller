class Symbol
  def is( klass )
    EnvConfig.add_config( self, klass )
  end
end