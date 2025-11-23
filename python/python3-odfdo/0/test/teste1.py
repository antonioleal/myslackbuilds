from odfdo import Document, Paragraph

doc = Document('text')
doc.body.append(Paragraph("Hello world!"))

doc.save("hello.odt")