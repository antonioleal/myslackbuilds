from odfdo import Document

doc = Document('existing_spreadsheet.ods')
sheet = doc.body.get_table(0)

print(f"Value of A1: {sheet.get_cell('A1').value}")
sheet.set_value('B2', 'Updated Value')

doc.save('modified_spreadsheet.ods')
