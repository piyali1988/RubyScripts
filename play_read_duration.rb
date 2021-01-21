def makefile(pathname)
    desktopPointer = File.expand_path("~/Documents/output/#{pathname}.csv")
    outfile = File.new(desktopPointer, 'w')
    return(outfile)
end

def writenames(outfile, colnames)
    outfile.write("#{colnames.join('|')}")
end

def writedata(outfile, data)
    outfile.write("\n#{data.join('|')}")
end

input_folder = 'Y:\\New Reorganization\\Research\\TMW\\TMW Longitudinal\\CHILDES material\\Transcription\\Completed Transcripts\\Completed Transcripts for Coding\\Session 3' # '~' is shortcut for home directory; ~/Desktop will usually get your desktop folder
#output_file = '~/Documents/output/output.csv'
#delimiter = '   ' # separator between data


#####################
### START HERE ! #####
#####################

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
     #     all you need to input is the name of the file
     toMyFile = makefile("#{file}")

     p_speech = getColumn("p_speech")
     play_read = getColumn("play_read")
     #play = getColumn('play')
     #cleanup = getColumn('cleanup')

     csvNames = [
         "file",
         "column",
         "onset_milli",
         "offset_milli",
         "onset",
         "offset",
         "Duration"
       ]

       writenames(toMyFile, csvNames)
       puts "Writing Files"

       #p_speech.cells.each do | thisp_speechCell |
           play_read.cells.each do | thisplay_readCell |

               #if thisp_speechCell.is_within(thisread_Cell)

               diff = thisplay_readCell.offset - thisplay_readCell.onset

               #find the milliseconds
                millisec_on = thisplay_readCell.onset % 1000
                millisec_of = thisplay_readCell.offset % 1000
                milli_diff = diff % 1000

               #find the seconds
                seconds_on = (thisplay_readCell.onset / 1000) % 60
                seconds_of = (thisplay_readCell.offset / 1000) % 60
                secs_diff = (diff / 1000) % 60
                #find the minutes
                minutes_on = ((thisplay_readCell.onset / 1000) / 60) % 60
                minutes_of = ((thisplay_readCell.offset / 1000) / 60) % 60
                mins_diff = ((diff / 1000) / 60) % 60
                #find the hours
                hours_on = (thisplay_readCell.onset/3600000)
                hours_of = (thisplay_readCell.offset/3600000)
                hours_diff = diff/3600000

                 lineData = [
                   "#{file}",
                   thisplay_readCell.code01,
                   thisplay_readCell.onset,
                   thisplay_readCell.offset,
                   hours_on.to_s + ":" + format("%02d",minutes_on.to_s) + ":" + format("%02d",seconds_on.to_s) + ":" + format("%03d",millisec_on.to_s),
                   hours_of.to_s + ":" + format("%02d",minutes_of.to_s) + ":" + format("%02d",seconds_of.to_s) + ":" + format("%03d",millisec_of.to_s),
                   hours_diff.to_s + ":" + format("%02d",mins_diff.to_s) + ":" + format("%02d",secs_diff.to_s) + ":" + format("%03d",milli_diff.to_s)
                   #{}"cleanup"
                 ]
                 writedata(toMyFile, lineData)

               #end
         #end
       end
  end

end
