#!/usr/bin/python
import sys
import datetime

template = """# {date}

## Work Objectives

### Planned

* [ ] 

## Rock Progress

* [FloatingTodoList](FloatingTodoList)
* [Rocks](../rocks/Rocks.md)

## Notes
"""

date = datetime.datetime.now().strftime("%Y-%m-%d") + " Notes"
print(template.format(date=date))
