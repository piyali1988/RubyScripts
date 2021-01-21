### Don't worry about these functions below. Skip to START HERE section.
### These functions are just helper functions to make things a little easier for you.

def makefile(pathname)
    desktopPointer = File.expand_path("~/Documents/920_VS1 exports/920_VS1S_c.csv")#{pathname}.csv")
    outfile = File.new(desktopPointer, 'w')
    return(outfile)
end

def writenames(outfile, colnames)
    outfile.write("#{colnames.join(',')}")
end

def writedata(outfile, data)
    outfile.write("\n#{data.join(',')}")
end

input_folder = 'Y:\New Reorganization\Research\TMW\TMW Longitudinal\CHILDES material\Transcription\Completed Transcripts\Completed Transcripts for Coding\Session 1\To be exported 2' # '~' is shortcut for home directory; ~/Desktop will usually get your desktop folder
output_file = '~/Desktop/output.csv'
delimiter = '   ' # separator between data


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

        # get information from the Datavyu column `trial`
        #     store this into the ruby variable called trial
     c_speech = getColumn("c_speech")
     if getColumn('spa_cate')
       spa_cate = getColumn('spa_cate')
     else
       puts "I can't guess the space"
     end
        # c_speech = getColumn("c_speech")


    # childes = getColumn('CHILDES_HEADER')

        csvNames = [
            "file_name",
            "spa_cate.spa_dimension",
            "spa_cate.spa_shape",
            "spa_cate.spa_featureproperty",
            "spa_cate.spa_locationdirection",
            "spa_cate.spa_amount",
            "spa_cate.spa_patternscomparison"

        ]

        writenames(toMyFile, csvNames)

        # p_speech.cells.each do | thisp_speechCell |
        #     plineData = [
        #     thisp_speechCell.utts]

        #     # writedata(toMyFile, plineData)

        c_speech.cells.each do | thisc_speechCell |
            spa_cate.cells.each do | thisspacate_Cell |

                if thisspacate_Cell.is_within(thisc_speechCell)

                        lineData = [
                        "#{file}",
                        thisspacate_Cell.dimension,
                        thisspacate_Cell.shape,
                        thisspacate_Cell.featureproperty,
                        thisspacate_Cell.locationdirection,
                        thisspacate_Cell.amount,
                        thisspacate_Cell.patternscomparisons,
                    ]

                        writedata(toMyFile, lineData)


                end
            end
        end
    end
end
