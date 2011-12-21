guard 'shell' do
  watch(%r{^(lib/.+\.rb)$}) do |m|
    %x(bundle exec rocco -o public #{m})
  end
end
