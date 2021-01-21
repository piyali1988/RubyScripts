
input_folder = 'Y:\New Reorganization\Research\TMW\TMW Longitudinal\CHILDES material\Transcription\Completed Transcripts\Completed Transcripts for Coding\Session 3'

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

  # Start making the file you want to create
  #     all you need to input is
  #toMyFile = makefile("#{file}")

        # get information from the Datavyu column `trial`
        #     store this into the ruby variable called trial
  p_speech = getColumn("p_speech")


    # do the same fo the `holding` column

    if getColumn('num_fun')
      num_fun = getColumn('num_fun')
    else
      puts "I can't guess the number"
      puts "#{data.push("#{file}")}"
    end
  end
end
