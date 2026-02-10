#!/usr/bin/env python3

from odfdo import Document, Paragraph

# Writer test
doc = Document('text')
doc.body.append(Paragraph("Hello world!"))
doc.save("hello.odt")

# Calc test
doc = Document('existing_spreadsheet.ods')
sheet = doc.body.get_table(0)
print(f"Value of A1: {sheet.get_cell('A1').value}")
sheet.set_value('B2', 'Updated Cell Value by odfdo')
doc.save('modified_spreadsheet.ods')
