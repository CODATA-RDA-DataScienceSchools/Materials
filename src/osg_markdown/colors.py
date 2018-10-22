
import re

from markdown.postprocessors import Postprocessor
from markdown.extensions import Extension

class ColorPostprocessor(Postprocessor):
    """ Take care of twiki-like colors """

    RE = re.compile(r'%([A-Za-z0-9_]+)%')

    def __init__(self, color):
        self.color = color

    def unescape(self, m):
        return '<span style="color:%s">%s</span>' % (self.color, m.group(1))

    def run(self, text):
        text = text.replace("%UCL_PROMPT_ROOT%", "[root@client ~]$")
        text = text.replace("%RED%", '<span style="color:red">')
        text = text.replace("%GREEN%", '<span style="color:green">')
        text = text.replace("%ENDCOLOR%", '</span>')
        return self.RE.sub(self.unescape, text)

class ColorExtension(Extension):
    """ Allow colors to be added to Markdown """

    def __init__(self, *args, **kw):
        self.config = {
            'color': ['red', 'Color to add'],
        }
        self.processor = ColorPostprocessor(self.getConfig('color', default='color'))

    def extendMarkdown(self, md, md_globals):
        md.postprocessors.add('color', self.processor, '_end')

def makeExtension(*args, **kwargs):
    return ColorExtension(*args, **kwargs)
