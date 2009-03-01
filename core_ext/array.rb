class Array
  def is( klass )
    EnvConfig.add_config( self, klass )
  end
end