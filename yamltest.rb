require 'yaml'
a = { 'languages' => [ 'Ruby', 'Perl', 'Python' ], 
  'websites' => { 
    'YAML' => 'yaml.org', 
    'Ruby' => 'ruby-lang.org', 
    'Python' => 'python.org', 
    'Perl' => 'use.perl.org'  
  } 
}
puts a.to_yaml
