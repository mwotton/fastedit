fastedit
========

spelling autocorrect algorithm based on the ideas in
http://blog.faroo.com/2012/06/07/improved-edit-distance-based-spelling-correction/


USAGE
=====

```
*Text.FastEdit> neighbours <- buildDict 2 . lines <$> readFile "/usr/share/dict/words"
*Text.FastEdit> neighbours "gold"
["gold","golds","old","god","golden","gold's","golfed","fold","cold","sold","hold","mold","bold","told","geld","glad","gild","goad","gods","good","golf","goal","go","old's","ogled","solid","olden","poled","holds","Golda","soled","would","Gould","molds","oiled","folds","world","holed","could","colds","scold","oldie","moldy","older","doled","gland","glads","glade","gilds","guild","glued","gelds","gelid","glide","goods","geode","gored","gonad","god's","goody","gourd","godly","goads","golly","growl","goals","Gogol","ghoul","Algol","golfs"]
````

TODO
====

* bench against edit-distance over whole dictionary
* work out if we can recover standard levenshtein semantics (we don't
  currently allow substitution or transposition)
* stop talking in the royal plural
