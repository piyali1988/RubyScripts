### Don't worry about these functions below.
### These functions are just helper functions to make things a little easier...

def makefile(pathname)
    desktopPointer = File.expand_path("~/Documents/New Exports/#{pathname}.csv")
    outfile = File.new(desktopPointer, 'w')
    return(outfile)
end

def writenames(outfile, colnames)
    outfile.write("#{colnames.join('|')}")
end

def writedata(outfile, data)
    outfile.write("\n#{data.join('|')}")
end

##PATHS##

#TMW PATH: 'Z:\\New Reorganization\\Research\\TMW\\TMW Longitudinal\\CHILDES material\\Transcription\\Completed Transcripts for Coding\\Session 1' ----->BE SURE TO CHANGE SESSION NUMBER FOR EXPORT
#WELL BABY ES PATH: 'Z:\\New Reorganization\\Research\\Well Baby\\WB Spanish Transcripts'

input_folder = 'Y:\\New Reorganization\\Research\\TMW\\TMW Longitudinal\\CHILDES material\\Transcription\\Completed Transcripts\\Completed Transcripts for Coding\\Session 5'
# input_folder = 'Z:\\New Reorganization\\Research\\Well Baby\\WB Spanish Transcripts' # '~' is shortcut for home directory; ~/Desktop will usually get your desktop folder
output_file = '~/Desktop/output.csv'
delimiter = '|' # separator between data

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

    toMyFile = makefile("#{file}")

        p_speech = getColumn("p_speech")

        c_speech = getColumn("c_speech")

        # childes = getColumn('CHILDES_HEADER')

        csvNames = [
            "file_name",
            "speaker_label",
            "speech",
            "speech_onset",
            "speech_offset"
            # "childes_header"

        ]

        writenames(toMyFile, csvNames)

        # ignore this block here

        # p_speech.cells.each do | thisp_speechCell |
        #     plineData = [
        #     thisp_speechCell.utts]

        #     writedata(toMyFile, plineData)


        # childes.cells.each do | thischildes_Cell |
        #     lineData = [
        #     "#{file}",
        #     thischildes_Cell.languages,
        #     thischildes_Cell.participants,
        #     thischildes_Cell.options,
        #     thischildes_Cell.media,
        #     thischildes_Cell.transcriber,
        #     thischildes_Cell.dateofsession,
        #     thischildes_Cell.dateoftranscription,
        #     thischildes_Cell.timeduration
        # ]

        #     writedata(toMyFile, lineData)

        # end

        c_speech.cells.each do | thisc_speechCell |
            lineData = [
            "#{file}",
            'c_speech',
            thisc_speechCell.utts,
            thisc_speechCell.onset,
            thisc_speechCell.offset
            # thisc_speechCell.key
            ]

            writedata(toMyFile, lineData)


        end

        p_speech.cells.each do | thisp_speechCell |
            plineData = [
            "#{file}",
            'p_speech',
            thisp_speechCell.utts,
            thisp_speechCell.onset,
            thisp_speechCell.offset
            # thisp_speechCell.key
        ]

            writedata(toMyFile, plineData)

        end
    end
end
