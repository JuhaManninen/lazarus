{  $Id$  }
{
 /***************************************************************************
                               allsyneditunits.pp

                      dummy unit to compile all units 

 /***************************************************************************
}
unit AllSynEditUnits;

{$mode objfpc}{$H+}

interface

uses
  SynTextDrawer, SynEditKeyCmds, SynEditTypes, SynEditStrConst,
  SynEditSearch, SynEditMiscProcs, SynEditmiscClasses, SynEditTextbuffer,
  SynEdit, SynEditHighlighter, SynCompletion, SynEditAutoComplete, 
  SynEditLazDsgn, SynRegExpr, SynEditRegexSearch, SynEditExport, 
  SynExportHTML, SynMemo, SynMacroRecorder, SynEditPlugins,
  SynPluginSyncronizedEditBase, SynPluginTemplateEdit,
  SynHighlighterAny,
  SynhighlighterCPP, 
  SynHighlighterCss, 
  SynHighlighterHashEntries, 
  SynhighlighterHTML, 
  SynHighlighterJava,
  SynHighlighterJScript,
  SynHighlighterLFM, 
  SynHighlighterMulti,
  SynHighlighterPas,
  SynHighlighterPerl, 
  SynHighlighterPHP,
  SynHighlighterPosition, 
  SynHighlighterPython, 
  SynHighlighterSQL,
  SynHighlighterTeX, 
  SynHighlighterUNIXShellScript, 
  SynHighlighterVB, 
  SynHighlighterXML,
  SynGutter, SynGutterChanges, SynGutterCodeFolding, SynGutterLineNumber, SynGutterMarks,
  SynPropertyEditObjectList, SynDesignStringConstants;

implementation

end.

