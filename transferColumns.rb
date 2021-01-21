##  Author: Piyali datavyu_files
##  Date Created: December 09, 2020
##  This script copies specific columns from playread folder to completed transcripts

input_folder = 'K:\\New Reorganization\\Research\\TMW\\TMW Longitudinal\\CHILDES material\\Transcription\\play_read\\video_session2\\Final\\' # '~' is shortcut for home directory;
output_folder = 'K:\\New Reorganization\\Research\\TMW\\TMW Longitudinal\\CHILDES material\\Transcription\\Completed Transcripts\\Completed Transcripts for Coding with playread\\Session 2\\'

require 'Datavyu_API.rb'

begin

  # Get list of opf files in input folder
  infiles = get_datavyu_files_from(input_folder)

  # Get list of opf files in input folder
  outfiles = get_datavyu_files_from(output_folder)

  # Init an empty list to store lines of data
  data = []
  # Loop over all Datavyu files (files in directory that end with ".opf" )
  for file in infiles
      #puts "Opening input" + file
      input_path = File.join(File.expand_path(input_folder), file)

      match_file = outfiles.detect{ |x| x == file }
      #output_path = File.join(File.expand_path(output_folder), match_file)
      raise "No matching file found!" if match_file.nil?
      #puts "Found matching file: #{match_file}"

      sourceFile = input_path
      #puts "source:" + sourceFile
      destinationFile = File.join(File.expand_path(output_folder), match_file)
      puts "destination:" + destinationFile
      columnsToTransfer = ['play', 'read', 'cleanup','play_read']
      transfer_columns(sourceFile, destinationFile, false, columnsToTransfer)

  end
end
