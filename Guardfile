# More info at https://github.com/guard/guard#readme
guard 'minitest' do
  watch(%r|^test/(.*)\/?test_(.*)\.rb|)
  watch(%r|^app/lib/(.*)/(.*)\.rb|) { |m| "test/test_#{m[1]}_#{m[2]}.rb" }
  watch(%r|^app/lib/(.*)\.rb|)      { |m| "test/test_#{m[1]}.rb" }
  watch(%r|^test/helper\.rb|)       { "test" }
end
