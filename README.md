fastedit
========

spelling autocorrect algorithm based on the ideas in
http://blog.faroo.com/2012/06/07/improved-edit-distance-based-spelling-correction/


USAGE
=====

```
*Text.FastEdit> neighbours <- buildDict 3 . lines <$> readFile "/usr/share/dict/words"
*Text.FastEdit> take 10 $ neighbours "gold"
["gold","golds","old","god","golden","gold's","golfed","fold","cold","sold"]
````

TODO
====

* bench against edit-distance over whole dictionary
* come up with less desperately anodyne name
* work out if we can recover standard levenshtein semantics (we don't
  currently allow substitution or transposition)
* stop talking in the royal plural
