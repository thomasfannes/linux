task :link do
    tgt = File.join(ENV['HOME'], ".vimrc")
    src = File.join(Dir.pwd(), "vimrc")
    if !File.exists?(tgt)
    	sh "ln -s #{src} #{tgt}"
    end
end
