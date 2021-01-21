out_file = File.expand_path("H:\\dbyrne")
out = File.new(out_file,'w')

# Locate the files in the datafiles folder on the Desktop
# and assign the list of file names to the filenames Ruby
# object.
filedir = File.expand_path("H:\\dbyrne\\Space_VS1_ML_Project")
filenames = Dir.new(filedir).entries

# Iterate through each filename in the "filenames" list
for file in filenames
   if file.include?(".opf") and file[0].chr != '.'

   puts "LOADING DATABASE: " + filedir+file
   $db,proj = load_db(filedir+file)
   puts "SUCCESSFULLY LOADED"


   # Retrieve "id", "trial", and "foot" columns

  number_word = getColumn("number word")
  # n_social_cons = getColumn("n_social_cons")
  c_speech = getColumn("c_speech")
  p_speech = getColumn("p_speech")
  # n_new_type = getColumn("n_new_type")
  # n_new_gesture = getColumn("n_new_gesture")
  # num_fun = getColumn("num_fun")
  # s_social_cons = getColumn("s_social_cons")
  # s_new_type = getColumn("s_new_type")
  # spa_cate = getColumn("spa_cate")
  # s_gesture = getColumn("s_gesture")
  # chi_act_utt = getColumn("chi_act_utt")
  # chi_gesture = getColumn("chi_gesture")
  # pcg_act_utt = getColumn("pcg_act_utt")

  for ncell in number_word.cells
      for ccell in c_speech.cells
         for pcell in p_speech.cells
            if ccell.onset >= pcell.onset && ccell.offset <= pcell.offset
               # Write the cells' codes to the output file, separated by tabs - the "\t"
               # You must include a newline indicated, "\n" so that the next cells' codes
               # will be output on a new line, giving them their own row.
               out.write(ncell.idnum + "\t" + pcell.onset.to_s + "\t" +
                   pcell.offset.to_s + "\t" + pcell.trial + "\t" +
                   fcell.ordinal.to_s + "\t" + ccell.onset.to_s + "\t" +
                   fcell.offset.to_s + "\t" + ccell.side + "\n")
               # End the if clause, and the for loops, as well as the script
            end
         end
      end
   end
  
