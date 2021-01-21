
input_folder = 'Y:\New Reorganization\Research\TMW\TMW Longitudinal\CHILDES material\Transcription\Completed Transcripts\Completed Transcripts for Coding\Session 5'

require 'Datavyu_API.rb'
begin

  # Get list of opf files
infiles = get_datavyu_files_from(input_folder)

# Init an empty list to store lines of data
data = []

  # Loop over all Datavyu files (files in directory that end with ".opf" )
  for file in infiles
      puts "Opening " + file
      input_path = File.join(File.expand_path(input_folder), file)
      $db, $pj = loadDB(input_path)

  #make sure file at least has a p_speech column
  p_speech = getColumn("p_speech")

  #checks to make sure the file has the desired column
    if getColumn('spa_cate')
      spa_cate = getColumn('num_fun')
    else
  #if it does not, adds the file name to an array called 'data'
      puts "I can't guess the number"
      puts "#{data.push("#{file}")}"
    end
  end
end
