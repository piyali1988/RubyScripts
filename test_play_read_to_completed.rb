def makefile(pathname)
    desktopPointer = File.expand_path("~/Documents/output/#{pathname}.csv")
    outfile = File.new(desktopPointer, 'w')
    return(outfile)
end


input_folder = '~/Documents/' # '~' is shortcut for home directory; ~/Desktop will usually get your desktop folder
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

     read = getColumn('read')
     play = getColumn('play')
     cleanup = getColumn('cleanup')

     csvNames = [
         "read",
         "play",
         "cleanup"
       ]

       writenames(toMyFile, csvNames)
       puts "Writing Files"

       lineData = [
         "read",
         "play",
         "cleanup"
       ]
       writedata(toMyFile, lineData)


  end

end
