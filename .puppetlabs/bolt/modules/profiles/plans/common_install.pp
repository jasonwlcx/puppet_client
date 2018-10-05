plan profiles::common_install(
  TargetSpec $nodes,
) {
  # Install puppet on the target and gather facts
  $nodes.apply_prep

  # Compile the manifest block into a catalog 
  apply($nodes) {
    # common packages needed everywhwere
    package {[
	    'vim',
	    'screen'
      ]:
      ensure => present,
    }

  }
}
