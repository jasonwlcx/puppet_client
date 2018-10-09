plan profiles::nginx_install(
  TargetSpec $nodes,
  String $site_content = 'hello world - thanks puppet!',
) {
  # Install puppet on the target and gather facts
  $nodes.apply_prep

  # Compile the manifest block into a catalog 
  apply($nodes) {
   if($facts['os']['family'] == 'redhat') {
    package { 'epel-release':
      ensure => present,
      before => Package['nginx'],
    }}
    package { 'nginx':
      ensure => present,
    }

    file { '/usr/share/nginx/html/index.html':
      content => $site_content,
      ensure  => file,
    }

    service { 'nginx':
      ensure  => 'running',
      enable  => 'true',
      require => Package['nginx'],
    }
  }
}
