## Laboratory work #4

For starters, here are the four programming languages allowed:
- C++
- Java
- C#
- Smalltalk (pharo or squeak, I don't thing things differ too much. If they do, please tell me.).Once that's clear, let's move on.

### The task

You'll have to write a program that takes a URL and gives the number of words of the article located at that URL. There URL can be from three possible sources:

- The Atlantic (http://www.theatlantic.com/magazine/archive/1945/07/as-we-may-think/303881/)
- NY Times (http://www.nytimes.com/2012/02/19/magazine/shopping-habits.html)
- The New Yorker (http://www.newyorker.com/magazine/2012/08/06/marathon-man?currentPage=all)

Please count only the words in the article body, excluding comments, author name, article name, etc.

### The grading requirements

7. Your program takes a string and tells what source it is
8. You have a program that can successfully count the number of words in any of the articles above using a Template Method pattern
9. Your code has at most 2 branching statements (ifs, branches of case or anything that maps to a jump)
10. You can start supporting The Economist articles by adding only:
  - one file with the code of the Economist class
  - only add/change at most 1 instruction in any other file (so you can use `new MyAwesomeEconomistAdapter()` )

### Can I use X?

Apart from the languages, you can use the following tech:

- A proper HTML, XML, SAX parser. See this post for details: http://stackoverflow.com/a/1732454/838871
- A library to do HTTP requests.
- I don't recommend messing with testing libraries for now. If your language supports something that looks like an assert, use that.
- Oh, and no Objective-C.
