### Don't worry about these functions below. Skip to START HERE section.
### These functions are just helper functions to make things a little easier for you.

def makefile(pathname)
    desktopPointer = File.expand_path("~/Documents/#{pathname}.txt")
    outfile = File.new(desktopPointer, 'w')
    return(outfile)
end

def writenames(outfile, colnames)
    outfile.write("#{colnames.join(',')}")
end

def writedata(outfile, data)
    outfile.write("\n#{data.join(',')}")
end

input_folder = 'Z:\New Reorganization\RAs\Diego\Session 3' # '~' is shortcut for home directory; ~/Desktop will usually get your desktop folder
output_file = '~/Desktop/output.csv'
delimiter = '   ' # separator between data

#####################
### START HERE ! #####
#####################


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
        p_speech = getColumn("p_speech")

        c_speech = getColumn("c_speech")

        s_social_cons = getColumn('s_social_cons')

        csvNames = [
            "social_1",
            "s_2",
            "s_3",
            "s_4"
        ]

        writenames(toMyFile, csvNames)

        # p_speech.cells.each do | thisp_speechCell |
        #     plineData = [
        #     thisp_speechCell.utts]

        #     # writedata(toMyFile, plineData)

        
        s_social_cons.cells.each do | thissocialcon_Cell |
            lineData = [
            # "#{file}",
            thissocialcon_Cell.childinitiated,
            thissocialcon_Cell.didactic,
            thissocialcon_Cell.incidentalunclear,
            thissocialcon_Cell.unsure,
        ]

            writedata(toMyFile, lineData)

        end
        
        # c_speech.cells.each do | thisc_speechCell |
        #     lineData = [
        #     # "#{file}",
        #     # 'c_speech',
        #     # thisc_speechCell.utts,
        #     thisc_speechCell.onset,
        #     thisc_speechCell.offset
        #     ]   

        #     writedata(toMyFile, lineData)
        
        
        # end

        # p_speech.cells.each do | thisp_speechCell |
        #     plineData = [
        #     # "#{file}",
        #     # 'p_speech',
        #     # thisp_speechCell.utts,
        #     thisp_speechCell.onset,
        #     thisp_speechCell.offset]

        #     writedata(toMyFile, plineData)

        # end
    end
end
