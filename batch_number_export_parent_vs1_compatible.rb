### Don't worry about these functions below. Skip to START HERE section.
### These functions are just helper functions to make things a little easier for you.

def makefile(pathname)
  desktopPointer = File.expand_path("~/Documents/VS1 Num Parent 2/#{pathname}.csv")
  outfile = File.new(desktopPointer, 'w')
  return(outfile)
end

def writenames(outfile, colnames)
  outfile.write("#{colnames.join(',')}")
end

def writedata(outfile, data)
  outfile.write("\n#{data.join(',')}")
end

input_folder = 'C:\\Users\\acaniglia\\Documents\\VS1 To be exported' # '~' is shortcut for home directory; ~/Desktop will usually get your desktop folder
output_file = '~/Desktop/output_10_7_test.csv'
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
  #     all you need to input is
  toMyFile = makefile("#{file}")

        # get information from the Datavyu column `trial`
        #     store this into the ruby variable called trial
  p_speech = getColumn("p_speech")


    # do the same fo the `holding` column

    if getColumn('num_fun')
      num_fun = getColumn('num_fun')
    else
      puts "I can't guess the number"
    end

    if getColumn('number_word')
      number_word = getColumn('number_word')
    else
      puts "uhoh"
    end

    # spatial_word = getColumn("spatial_word")
    # spa_cate = getColumn("spa_cate")

    # These are the names that will go at the top of each .csv file.
    #    it is up to you to make sure they match up correctly with the data
    #    this means same number of columns as data and same order
    # Notice the brackets, which means this is an array of strings
    # Each items is enclosed in quotes
    # Each item is separated by a comma expected for the last
    csvNames = [
        # "p_speechCell",
        # # "p_speechOnset",
        # # "p_speechOffset",
        # # "spatial_wordCell",
        # # "spatial_wordOnset",
        # "spatial_wordCell",
        # "spa_dimension",
        # "spa_shape",
        # "spa_featureproperty",
        # "spa_locationdirection",
        # "spa_amount",
        # "spa_patterscomparison",
        "file_name",
        "num_fun.num_symbol",
        "num_fun.counting",
        "num_fun.countingnouns",
        "num_fun.cocounting",
        "num_fun.cardinality",
        "num_fun.cardinalitynouns",
        "num_fun.calculation",
        "num_fun.magnitude",
        "num_fun.measurement",
        "num_fun.conventionalnominatives",
        "num_fun.ordinality",

    ]

    # actually write the names you made to the file you started using the following function
    # the function `writenames` takes on 2 arguments
    #      arg1 = the variable name of the file you started
    #      arg2 = the column names you made as an array of strings
    writenames(toMyFile, csvNames)

    # start going through each cell in the `trial` column
    #     call each cell `thisTrialCell`
    p_speech.cells.each do | thisp_speechCell |

        # start going through each cell in the `holding` column
        #     call each cell `thisHoldCell`
       number_word.cells.each do | thisnumber_wordCell |
          num_fun.cells.each do | thisnum_fun_cateCell |

            # make sure the current holding cell is within the current trial cell
            #     this is based on onset/offset times
            #     if this is true, then collect data and write it to the file
              if thisnumber_wordCell.is_within(thisp_speechCell) && thisnum_fun_cateCell.is_within(thisp_speechCell)

                # collect the data from cells
                # the stuff before the `.` is the current cell name
                # the stuff after the `.` is the data from the current cell
                # ordinal, onset, offset always exists, anything else is custom
                  lineData = [
                     "#{file}",
                      thisnum_fun_cateCell.numbersymbol,
                      thisnum_fun_cateCell.counting,
                      thisnum_fun_cateCell.countingnouns,
                      thisnum_fun_cateCell.cocounting,
                      thisnum_fun_cateCell.cardinality,
                      thisnum_fun_cateCell.cardinalitynouns,
                      thisnum_fun_cateCell.calculation,
                      thisnum_fun_cateCell.magnitude,
                      thisnum_fun_cateCell.measurement,
                      thisnum_fun_cateCell.conventionalnominatives,
                      thisnum_fun_cateCell.ordinality,
                      # thisp_speechCell.ordinal,
                      # thisp_speechCell.onset,
                      # thisp_speechCell.offset,
                    #   thisspatial_wordCell.word,
                    #   thisspa_cateCell.dimension,
                    #   thisspa_cateCell.shape,
                    #   thisspa_cateCell.featureproperty,
                    #   thisspa_cateCell.locationdirection,
                    #   thisspa_cateCell.amount,
                    #   thisspa_cateCell.patterscomparisons
                      # thisspatial_wordCell.ordinal,
                      # thisspatial_wordCell.onset,
                      # thisspatial_wordCell.offset,
                      # thisTrialCell.word,
                      # thisHoldCell.toy
                  ]

                  # write the data as a single line in your output file
                  writedata(toMyFile, lineData)
                  end
               end
            end
         end
      end
   end
