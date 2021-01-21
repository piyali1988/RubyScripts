require 'Datavyu_API.rb'
begin
  num_fun = createColumn("num_fun", "numbersymbol",
  "counting",
  "countingnouns",
  "cocounting",
  "cardinality",
  "cardinalitynouns",
  "calculation",
  "magnitude",
  "measurement",
  "conventionalnominatives",
  "onetoone",
  "ordinality",
  "other")
  num_fun.make_new_cell()
  setColumn(num_fun)
end
begin
  spa_cate = createColumn("spa_cate", "dimension",
  "shape",
  "featureproperty",
  "locationdirection",
  "amount",
  "patternscomparison")
  spa_cate.make_new_cell()
  setColumn(spa_cate)
end
