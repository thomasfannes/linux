require 'fileutils'

desc 'link the vimrc file'
task :link do
    tgt = File.join(ENV['HOME'], ".vimrc")
    src = File.join(Dir.pwd(), "vimrc")
    if !File.exists?(tgt)
    	sh "ln -s #{src} #{tgt}"
    end
end

def link_it(src_dir, tgt_dir)
  src_dir = File.absolute_path(src_dir)
  tgt_dir = File.absolute_path(tgt_dir)
  Dir.chdir(src_dir) do
    Dir.glob("**/*", File::FNM_DOTMATCH).select {|f| File.file?(f) }.each do |f| 
      dir = File.join(tgt_dir, File.dirname(f))

      FileUtils.mkdir_p(dir) unless File.exist?(dir)

      fn = File.join(dir, File.basename(f))
      FileUtils.rm_f(fn) 
      
      FileUtils.ln_s(File.join(src_dir, f), dir)
    end
  end
end


desc 'install the xfce updates'
task :xfce do
  link_it("xfce", File.join(ENV['HOME'], "test"))
end
