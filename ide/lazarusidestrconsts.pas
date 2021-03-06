{
 /***************************************************************************
                          lazarusidestrconsts.pas
                          -----------------------
              This unit contains all resource strings of the IDE


 ***************************************************************************/

 ***************************************************************************
 *                                                                         *
 *   This source is free software; you can redistribute it and/or modify   *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This code is distributed in the hope that it will be useful, but      *
 *   WITHOUT ANY WARRANTY; without even the implied warranty of            *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
 *   General Public License for more details.                              *
 *                                                                         *
 *   A copy of the GNU General Public License is available on the World    *
 *   Wide Web at <http://www.gnu.org/copyleft/gpl.html>. You can also      *
 *   obtain it by writing to the Free Software Foundation,                 *
 *   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.        *
 *                                                                         *
 ***************************************************************************
}
{
  Note: All resource strings should be prefixed with 'lis' (Lazarus IDE String)

}
unit LazarusIDEStrConsts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ButtonPanel;

const
  PrimaryConfPathOptLong='--primary-config-path=';
  PrimaryConfPathOptShort='--pcp=';
  SecondaryConfPathOptLong='--secondary-config-path=';
  SecondaryConfPathOptShort='--scp=';
  NoSplashScreenOptLong='--no-splash-screen';
  NoSplashScreenOptShort='--nsc';
  StartedByStartLazarusOpt='--started-by-startlazarus';
  SkipLastProjectOpt='--skip-last-project';
  EnableRemoteControlOpt='--remote-control';
  DebugLogOpt='--debug-log=';
  LanguageOpt='--language=';

resourcestring
  lisErrInvalidOption = 'Invalid option at position %d: "%s"';
  lisErrNoOptionAllowed = 'Option at position %d does not allow an argument: %s';
  lisErrOptionNeeded = 'Option at position %d needs an argument : %s';

  lisEnterTransla = 'Enter translation language';
  // version
  lisLazarusVersionString = '%s beta'; // %s is the versionstring (eg. 0.9.10)
  lisLeaveEmptyFo = 'Leave empty for default .po file';
  lisMenuCollectPoFil = 'Collect .po files';
  lisMenuCreatePoFile = 'Create .po files';

  // command line help
  listhisHelpMessage = 'this help message';
  lisprimaryConfigDirectoryWhereLazarusStoresItsConfig =
    'primary config '+
    'directory, where Lazarus stores its config files. Default is ';
  lislazarusOptionsProjectFilename = 'lazarus [options] <project-filename>';
  lisIDEOptions = 'IDE Options:';
  lisCmdLineLCLInterfaceSpecificOptions =
    'LCL Interface specific options:';
  lisDoNotShowSplashScreen = 'Do not show splash screen';
  lisSkipLoadingLastProject = 'Skip loading last project';
  lisOverrideLanguage = 'Override language. For example --language=de.'+
    ' For possible values see files in the languages directory.';
  lissecondaryConfigDirectoryWhereLazarusSearchesFor =
    'secondary config '+
    'directory, where Lazarus searches for config template files. Default is ';
  lisFileWhereDebugOutputIsWritten =
    'file, where debug output is written to. If it is '+
    'not specified, debug output is written to the console.';

  // component palette
  lisSelectionTool = 'Selection tool';
  
  // macros
  lisCursorColumnInCurrentEditor = 'Cursor column in current editor';
  lisCursorRowInCUrrentEditor = 'Cursor row in current editor';
  lisCompilerFilename = 'Compiler filename';
  lisWordAtCursorInCurrentEditor = 'Word at cursor in current editor';
  lisExpandedFilenameOfCurrentEditor = 'Expanded filename of current editor file';
  lisFreePascalSourceDirectory = 'Freepascal source directory';
  lisLazarusDirectory = 'Lazarus directory';
  lisLazarusLanguageID = 'Lazarus language ID (e.g. en, de, br, fi)';
  lisLazarusLanguageName = 'Lazarus language name (e.g. english, deutsch)';
  lisLCLWidgetType = 'LCL Widget Type';
  lisCOVarious = '%s (various)';
  lisTargetCPU = 'Target CPU';
  lisTargetOS = 'Target OS';
  lisSrcOS = 'Src OS';
  lisCommandLineParamsOfProgram = 'Command line parameters of program';
  lisPromptForValue = 'Prompt for value';
  lisProjectFilename = 'Project filename';
  lisProjectDirectory = 'Project directory';
  lisSaveCurrentEditorFile = 'save current editor file';
  lisSaveAllModified = 'save all modified files';
  lisTargetFilenameOfProject = 'Target filename of project';
  lisTargetFilenamePlusParams = 'Target filename + params';
  lisTestDirectory = 'Test directory';
  lisLaunchingCmdLine = 'Launching target command line';
  lisPublishProjDir = 'Publish project directory';
  lisProjectUnitPath = 'Project Unit Path';
  lisProjectIncPath = 'Project Include Path';
  lisProjectSrcPath = 'Project Src Path';
  lisProjectOutDir = 'Project Output directory (e.g. the ppu directory)';
  lisEnvironmentVariableNameAsParameter = 'Environment variable, name as '
    +'parameter';
  lisUserSHomeDirectory = 'User''s home directory';
  lisMakeExe = 'Make Executable';
  lisProjectMacroProperties = 'Project macro properties';
  lisOpenProject2 = 'Open project';
  lisKMSaveProject = 'Save project';
  lisKMCloseProject = 'Close project';
  lisKMSaveProjectAs = 'Save project as';
  lisKMPublishProject = 'Publish project';
  lisOpenTheFileAsNormalSource = 'Open the file as normal source';
  lisOpenAsXmlFile = 'Open as XML file';
  lisAnErrorOccuredAtLastStartupWhileLoadingLoadThisPro = 'An error occured '
    +'at last startup while loading %s!%s%sLoad this project again?';
  lisOpenProjectAgain = 'Open project again';
  lisStartWithANewProject = 'Start with a new project';
  lisProjectMacroUnitPath = 'macro ProjectUnitPath';
  lisConfigDirectory = 'Lazarus config directory';

  // main bar menu
  lisMenuFile = '&File';
  lisMenuEdit = '&Edit';
  lisMenuSearch = '&Search';
  lisMenuView = '&View';
  lisMenuProject = '&Project';
  lisMenuRun = '&Run';
  lisMenuPackage = '&Package';
  lisMenuTools = '&Tools';
  lisMenuEnvironent = 'E&nvironment';
  lisMenuWindow = '&Window';
  lisMenuHelp = '&Help';
  
  lisMenuNewUnit = 'New Unit';
  lisMenuNewForm = 'New Form';
  lisMenuNewOther = 'New ...';
  lisMenuOpen = '&Open ...';
  lisMenuRevert = 'Revert';
  lisPkgEditPublishPackage = 'Publish Package';
  lisMenuOpenRecent = 'Open &Recent ...';
  lisMenuSave = '&Save';
  lisKMSaveAs = 'SaveAs';
  lisKMSaveAll = 'SaveAll';
  lisDiscardChanges = 'Discard changes';
  lisDoNotCloseTheProject = 'Do not close the project';
  lisDoNotCloseTheIDE = 'Do not close the IDE';
  lisMenuSaveAs = 'Save &As ...';
  lisMenuSaveAll = 'Save All';
  lisMenuClose = 'Close';
  lisConvert = 'Convert';
  lisPLDOnlyExistingFiles = 'Only existing files';
  lisPLDShowGlobalLinks = 'Show global links';
  lisPLDShowUserLinks = 'Show user links';
  lisPLDGlobal = 'Global';
  lisKMCloseAll = 'Close All';
  lisCTDefDefineTemplates = 'Define templates';
  lisMenuCloseAll = 'Close a&ll editor files';
  lisMenuCleanDirectory = 'Clean directory ...';
  lisMenuQuit = '&Quit';
  lisMenuRestart = 'Restart';

  lisMenuUndo = 'Undo';
  lisMenuRedo = 'Redo';
  lisMenuCut = 'Cut';
  lisMenuCopy = 'Copy';
  lisMenuPaste = 'Paste';
  lisMenuIndentSelection = 'Indent selection';
  lisMenuUnindentSelection = 'Unindent selection';
  lisMenuUpperCaseSelection = 'Uppercase selection';
  lisMenuLowerCaseSelection = 'Lowercase selection';
  lisMenuTabsToSpacesSelection = 'Tabs to spaces in selection';
  lisMenuEncloseSelection = 'Enclose selection ...';
  lisMenuCommentSelection = 'Comment selection';
  lisMenuUncommentSelection = 'Uncomment selection';
  lisMenuToggleComment = 'Toggle comment';
  lisKMInsertIFDEF = 'Insert $IFDEF';
  lisMenuConditionalSelection = 'Insert $IFDEF...';
  lisMenuSortSelection = 'Sort selection ...';
  lisMenuBeakLinesInSelection = 'Break Lines in selection';
  lisKMSelectWordLeft = 'Select word left';
  lisKMSelectWordRight = 'Select word right';
  lisKMSelectLineStart = 'Select line start';
  lisKMSelectLineEnd = 'Select line end';
  lisKMSelectPageTop = 'Select page top';
  lisKMSelectPageBottom = 'Select page bottom';
  lisMenuSelect = 'Select';
  lisMenuSelectAll = 'Select all';
  lisSAMAbstractMethodsNotYetOverridden = 'Abstract methods - not yet '
    +'overridden';
  lisMenuSelectToBrace = 'Select to brace';
  lisMenuSelectCodeBlock = 'Select code block';
  lisMenuSelectWord = 'Select word';
  lisMenuSelectLine = 'Select line';
  lisMenuSelectParagraph = 'Select paragraph';
  lisMenuInsertCharacter = 'Insert from Character Map';
  lisMenuInsertText = 'Insert text';
  lisMenuInsertCVSKeyword = 'CVS keyword';
  lisMenuInsertGeneral = 'General';
  lisNone2 = 'none';
  lisOr = 'or';
  lisNone = '%snone';
  lisUnitPaths = 'Unit paths';
  lisIncludePaths = 'Include paths';
  lisSourcePaths = 'Source paths';
  lisMenuCompleteCode = 'Complete Code';
  lisMenuExtractProc = 'Extract procedure ...';
  lisMenuFindIdentifierRefs = 'Find Identifier References ...';
  lisMenuRenameIdentifier = 'Rename Identifier ...';

  lisMenuInsertGPLNotice = 'GPL notice';
  lisMenuInsertLGPLNotice = 'LGPL notice';
  lisMenuInsertModifiedLGPLNotice = 'Modified LGPL notice';
  lisMenuInsertUserName = 'Current username';
  lisMenuInsertDateTime = 'Current date and time';
  lisMenuInsertChangeLogEntry = 'ChangeLog entry';

  lisMenuFind = 'Find';
  lisBtnFind = '&Find';
  lisMenuFindNext = 'Find &Next';
  lisMenuFind2 = '&Find ...';
  lisMenuFindPrevious = 'Find &Previous';
  lisMenuFindInFiles = 'Find &in files ...';
  lisBtnReplace = '&Replace';
  lisMenuReplace = 'Replace';
  lisMenuIncrementalFind = 'Incremental Find';
  lisMenuReplace2 = '&Replace ...';
  lisMenuGotoLine = 'Goto line ...';
  lisMenuJumpBack = 'Jump back';
  lisMenuJumpForward = 'Jump forward';
  lisMenuAddJumpPointToHistory = 'Add jump point to history';
  lisMenuViewJumpHistory = 'Jump-History ...';
  lisMenuFindBlockOtherEndOfCodeBlock = 'Find other end of code block';
  lisMenuFindCodeBlockStart = 'Find code block start';
  lisMenuFindDeclarationAtCursor = 'Find Declaration at cursor';
  lisMenuOpenFilenameAtCursor = 'Open filename at cursor';
  lisMenuGotoIncludeDirective = 'Goto include directive';
  lisMenuJumpToNextError = 'Jump to next error';
  lisMenuJumpToPrevError = 'Jump to previous error';
  lisMenuSetFreeBookmark = 'Set a free bookmark';
  lisMenuJumpToNextBookmark = 'Jump to next bookmark';
  lisMenuJumpToPrevBookmark = 'Jump to previous bookmark';

  lisMenuViewObjectInspector = 'Object Inspector';
  lisMenuViewSourceEditor = 'Source Editor';
  lisMenuViewCodeExplorer = 'Code Explorer';
  lisMenuViewCodeBrowser = 'Code Browser';
  lisMenuViewRestrictionBrowser = 'Restriction Browser';
  lisMenuViewComponents = '&Components';
  lisMenuJumpTo = 'Jump to';
  lisMenuViewUnits = 'Units...';
  lisMenuViewForms = 'Forms...';
  lisMenuViewUnitDependencies = 'Unit Dependencies';
  lisKMViewUnitInfo = 'View Unit Info';
  lisMenuViewUnitInfo = 'Unit Information';
  lisMenuViewToggleFormUnit = 'Toggle form/unit view';
  lisMenuViewMessages = 'Messages';
  lisCopySelectedMessagesToClipboard = 'Copy selected messages to clipboard';
  lisCopyAllMessagesToClipboard = 'Copy all messages to clipboard';
  lisCopyAllAndHiddenMessagesToClipboard = 'Copy all and hidden messages '
                                           +'to clipboard';
  lisSaveAllMessagesToFile = 'Save all messages to file';
  lisMVDocking = 'Docking';
  lisMenuViewSearchResults = 'Search Results';
  lisMenuViewAnchorEditor = 'Anchor Editor';
  lisKMToggleViewComponentPalette = 'Toggle view component palette';
  lisMenuViewComponentPalette = 'Component Palette';
  lisMenuViewTodoList = 'ToDo List';
  lisMenuViewIDESpeedButtons = 'IDE speed buttons';
  lisMenuDebugWindows = 'Debug windows';
  lisMenuViewWatches = 'Watches';
  lisMenuViewBreakPoints = 'BreakPoints';
  lisMenuViewLocalVariables = 'Local Variables';
  lisMenuViewRegisters = 'Registers';
  lisMenuViewCallStack = 'Call Stack';
  lisMenuViewAssembler = 'Assembler';
  lisMenuViewDebugOutput = 'Debug output';
  lisMenuIDEInternals = 'IDE internals';
  lisMenuPackageLinks = 'Package links ...';
  
  lisMenuNewProject = 'New Project ...';
  lisMenuNewProjectFromFile = 'New Project from file ...';
  lisMenuOpenProject = 'Open Project ...';
  lisMenuCloseProject = 'Close Project';
  lisMenuOpenRecentProject = 'Open Recent Project ...';
  lisMenuSaveProject = 'Save Project';
  lisMenuSaveProjectAs = 'Save Project As ...';
  lisMenuPublishProject = 'Publish Project ...';
  lisMenuProjectInspector = 'Project Inspector';
  lisKMAddActiveUnitToProject = 'Add active unit to project';
  lisKMRemoveActiveUnitFromProject = 'Remove active unit from project';
  lisKMViewProjectSource = 'View project source';
  lisMenuAddToProject = 'Add editor file to Project';
  lisMenuRemoveFromProject = 'Remove from Project ...';
  lisMenuViewSource = '&View Source';
  lisMenuProjectOptions = 'Project Options ...';
  
  lisMenuBuild = 'Build';
  lisBFWorkingDirectoryLeaveEmptyForFilePath = 'Working directory (Leave '
    +'empty for file path)';
  lisBFBuildCommand = 'Build Command';
  lisMenuBuildAll = 'Build all';
  lisMenuQuickCompile = 'Quick compile';
  lisMenuAbortBuild = 'Abort Build';
  lisMenuProjectRun = 'Run';
  lisBFAlwaysBuildBeforeRun = 'Always Build before Run';
  lisBFWorkingDirectoryLeaveEmptyForFilePath2 = 'Working Directory (Leave '
    +'empty for file path)';
  lisBFRunCommand = 'Run Command';
  lisMenuPause = 'Pause';
  lisMenuStepInto = 'Step into';
  lisMenuStepOver = 'Step over';
  lisMenuRunToCursor = 'Run to cursor';
  lisKMStopProgram = 'Stop program';
  lisMenuStop = 'Stop';
  lisContinue = 'Continue';
  lisMenuResetDebugger = 'Reset debugger';
  lisKMCompilerOptions = 'Compiler options';
  lisMenuCompilerOptions = 'Compiler Options ...';
  lisMenuRunParameters = 'Run Parameters ...';
  lisMenuBuildFile = 'Build File';
  lisMenuRunFile = 'Run File';
  lisKMConfigBuildFile = 'Config %sBuild File%s';
  lisKMInspect = 'Inspect';
  lisKMEvaluateModify = 'Evaluate/Modify';
  lisKMAddWatch = 'Add watch';
  lisMenuConfigBuildFile = 'Configure Build+Run File ...';
  lisMenuInspect = 'Inspect ...';
  lisMenuEvaluate = 'Evaluate/Modify ...';
  lisMenuAddWatch= 'Add watch ...';
  lisMenuAddBreakpoint = 'Add breakpoint';
  lisMenuAddBpSource = 'Source breakpoint';

  lisInspectDialog = 'Debug Inspector';
  lisInspectData = 'Data';
  lisInspectProperties = 'Properties';
  lisInspectMethods = 'Methods';

  lisMenuNewPackage = 'New package ...';
  lisMenuOpenPackage = 'Open loaded package ...';
  lisMenuOpenRecentPkg = 'Open recent package ...';
  lisMenuOpenPackageFile = 'Open package file (.lpk) ...';
  lisMenuOpenPackageOfCurUnit = 'Open package of current unit';
  lisMenuAddCurUnitToPkg = 'Add active unit to a package';
  lisKMPackageGraph = 'Package graph';
  lisKMConfigureInstalledPackages = 'Configure installed packages';
  lisKMConfigureCustomComponents = 'Configure custom components';
  lisMenuPackageGraph = 'Package Graph ...';
  lisMenuEditInstallPkgs = 'Configure installed packages ...';
  lisMenuConfigCustomComps = 'Configure custom components ...';

  lisMenuConfigExternalTools = 'Configure external tools ...';
  lisMenuQuickSyntaxCheck = 'Quick syntax check';
  lisMenuQuickSyntaxCheckOk = 'Quick syntax check OK';
  lisMenuGuessUnclosedBlock = 'Guess unclosed block';
  lisMenuGuessMisplacedIFDEF = 'Guess misplaced IFDEF/ENDIF';
  lisMenuMakeResourceString = 'Make Resource String ...';
  lisMenuDiff = 'Diff';
  lisMenuConvertDFMtoLFM = 'Convert DFM file to LFM ...';
  lisMenuCheckLFM = 'Check LFM file in editor';
  lisMenuConvertDelphiUnit = 'Convert Delphi unit to Lazarus unit ...';
  lisMenuConvertDelphiProject = 'Convert Delphi project to Lazarus project ...';
  lisMenuConvertDelphiPackage = 'Convert Delphi package to Lazarus package ...';
  lisMenuConvertEncoding = 'Convert encoding of projects/packages ...';
  lisMenuBuildLazarus = 'Build Lazarus';
  lisMenuConfigureBuildLazarus = 'Configure "Build Lazarus" ...';
  
  lisMenuGeneralOptions = 'Options ...';
  lisMenuEditorOptions = 'Editor options ...';
  lisMenuEditCodeTemplates = 'Code Templates ...';
  lisMenDebuggerOptions = 'Debugger Options ...';
  lisMenuCodeToolsOptions = 'CodeTools Options ...';
  lisMenuCodeToolsDefinesEditor = 'CodeTools defines editor ...';
  
  lisMenuOnlineHelp = 'Online Help';
  lisMenuReportingBug = 'Reporting a bug...';
  lisReportingBugURL = 'http://wiki.lazarus.freepascal.org/How_do_I_create_a_bug_report';
  lisKMConfigureHelp = 'Configure Help';
  lisKMContextSensitiveHelp = 'Context sensitive help';
  lisKMEditContextSensitiveHelp = 'Edit context sensitive help';
  lisMenuConfigureHelp = 'Configure Help ...';
  lisMenuContextHelp = 'Context sensitive Help';
  lisMenuEditContextHelp = 'Edit context sensitive Help';
  lisMenuCreateFPDocFiles = 'Create FPDoc files';

  lisDsgCopyComponents = 'Copy selected components to clipboard';
  lisDsgCutComponents = 'Cut selected components to clipboard';
  lisDsgPasteComponents = 'Paste selected components from clipboard';
  lisDsgSelectParentComponent = 'Select parent component';
  lisDsgOrderMoveToFront = 'Move component to front';
  lisDsgOrderMoveToBack = 'Move component to back';
  lisDsgOrderForwardOne = 'Move component one forward';
  lisDsgOrderBackOne = 'Move component one back';

  // main
  lisChooseProgramSourcePpPasLpr = 'Choose program source (*.pp,*.pas,*.lpr)';
  lisProgramSourceMustHaveAPascalExtensionLikePasPpOrLp = 'Program source '
    +'must have a pascal extension like .pas, .pp or .lpr';
  lisCompilerOptionsForProject = 'Compiler Options for Project: %s';
  lisChooseDelphiUnit = 'Choose Delphi unit (*.pas)';
  lisChooseDelphiProject = 'Choose Delphi project (*.dpr)';
  lisChooseDelphiPackage = 'Choose Delphi package (*.dpk)';
  lisDelphiProject = 'Delphi project';
  lisUnableToReadFileError = 'Unable to read file %s%s%s%sError: %s';
  lisFormatError = 'Format error';
  lisLFMFileCorrupt = 'LFM file corrupt';
  lisUnableToFindAValidClassnameIn = 'Unable to find a valid classname in %s%'
    +'s%s';
  lisUnableToConvertFileError = 'Unable to convert file %s%s%s%sError: %s';
  lisUnableToWriteFileError = 'Unable to write file %s%s%s%sError: %s';
  lisErrorCreatingLrs = 'Error creating lrs';
  lisLFMFileNotFound = 'LFM file not found';
  lisTheFollowingUnitsWereNotFound1EitherTheseUnitsAreN = 'The following '
    +'units were not found:%s%s%s%s1) Either these units are not in the unit '
    +'path, then you can abort now, fix the unit path and try again.%s'
    +'2) Or you can ignore the missing units and comment them out.';
  lisUnitNotFound = 'Unit not found';
  lisUnitsNotFound2 = 'Units not found';
  lisUnitLFMFile = 'Unit: %s%sLFM file: %s';
  lisUnableToConvertLfmToLrsAndWriteLrsFile = 'Unable to convert lfm to lrs '
    +'and write lrs file.';
  lisNotADelphiProject = 'Not a Delphi project';
  lisTheFileIsNotADelphiProjectDpr = 'The file %s%s%s is not a Delphi '
    +'project (.dpr)';
  lisUnableToLoadOldResourceFileTheResourceFileIs = 'Unable to load old '
    +'resource file.%sThe resource file is the first include file in the%'
    +'sinitialization section.%sFor example {$I %s.lrs}.%sProbably a syntax '
    +'error.';
  lisResourceLoadError = 'Resource load error';
  lisIgnoreMissingFile = 'Ignore missing file';
  lisnoname = 'noname';
  lisTheDestinationDirectoryDoesNotExist = 'The destination directory%s%s%s%s '
    +'does not exist.';
  lisRenameFile = 'Rename file?';
  lisThisLooksLikeAPascalFileItIsRecommendedToUseLowerC = 'This looks like a '
    +'pascal file.%sIt is recommended to use lower case filenames, to avoid '
    +'various problems on some filesystems and different compilers.%sRename '
    +'it to lowercase?';
  lisRenameToLowercase = 'Rename to lowercase';
  lisKeepName = 'Keep name';
  lisOverwriteFile = 'Overwrite file?';
  lisAFileAlreadyExistsReplaceIt = 'A file %s%s%s already exists.%sReplace it?';
  lisOverwriteFileOnDisk = 'Overwrite file on disk';
  lisAmbiguousFilesFound = 'Ambiguous files found';
  lisThereAreOtherFilesInTheDirectoryWithTheSameName = 'There are other files '
    +'in the directory with the same name,%swhich only differ in case:%s%s%'
    +'sDelete them?';
  lisDeleteOldFile = 'Delete old file %s%s%s?';
  lisDeletingOfFileFailed = 'Deleting of file %s%s%s failed.';
  lisStreamingError = 'Streaming error';
  lisUnableToStreamT = 'Unable to stream %s:T%s.';
  lisResourceSaveError = 'Resource save error';
  lisUnableToAddResourceHeaderCommentToResourceFile = 'Unable to add resource '
    +'header comment to resource file %s%s%s%s.%sProbably a syntax error.';
  lisUnableToAddResourceTFORMDATAToResourceFileProbably = 'Unable to add '
    +'resource T%s:FORMDATA to resource file %s%s%s%s.%sProbably a syntax '
    +'error.';
  lisUnableToCreateFile2 = 'Unable to create file %s%s%s';
  lisContinueWithoutLoadingForm = 'Continue without loading form';
  lisCancelLoadingUnit = 'Cancel loading unit';
  lisAbortAllLoading = 'Abort all loading';
  lisUnableToTransformBinaryComponentStreamOfTIntoText = 'Unable to transform '
    +'binary component stream of %s:T%s into text.';
  lisTheFileWasNotFoundIgnoreWillGoOnLoadingTheProject = 'The file %s%s%s%'
    +'swas not found.%sIgnore will go on loading the project,%sAbort  will '
    +'stop the loading.';
  lisSkipFileAndContinueLoading = 'Skip file and continue loading';
  lisAbortLoadingProject = 'Abort loading project';
  lisFileNotFound2 = 'File %s%s%s not found.%s';
  lisFileNotFoundDoYouWantToCreateIt = 'File %s%s%s not found.%sDo you want '
    +'to create it?%s';
  lisProjectInfoFileDetected = 'Project info file detected';
  lisTheFileSeemsToBeTheProgramFileOfAnExistingLazarusP = 'The file %s seems '
    +'to be the program file of an existing lazarus Project.';
  lisTheFileSeemsToBeAProgramCloseCurrentProject = 'The file %s%s%s%sseems to '
    +'be a program. Close current project and create a new lazarus project '
    +'for this program?%s"No" will load the file as normal source.';
  lisProgramDetected = 'Program detected';
  lisUnableToConvertTextFormDataOfFileIntoBinaryStream = 'Unable to convert '
    +'text form data of file %s%s%s%s%sinto binary stream. (%s)';
  lisFormLoadError = 'Form load error';
  lisSaveProjectLpi = 'Save Project %s (*.lpi)';
  lisInvalidProjectFilename = 'Invalid project filename';
  lisisAnInvalidProjectNamePleaseChooseAnotherEGProject = '%s%s%s is an '
    +'invalid project name.%sPlease choose another (e.g. project1.lpi)';
  lisTheNameIsNotAValidPascalIdentifier = 'The name %s%s%s is not a valid '
    +'pascal identifier.';
  lisChooseADifferentName = 'Choose a different name';
  lisTheProjectInfoFileIsEqualToTheProjectMainSource = 'The project info '
    +'file %s%s%s%sis equal to the project main source file!';
  lisUnitIdentifierExists = 'Unit identifier exists';
  lisThereIsAUnitWithTheNameInTheProjectPleaseChoose = 'There is a unit with the '
    +'name %s%s%s in the project.%sPlease choose a different name';
  lisErrorCreatingFile = 'Error creating file';
  lisUnableToCreateFile3 = 'Unable to create file%s%s%s%s';
  lisCopyError2 = 'Copy error';
  lisSourceDirectoryDoesNotExist = 'Source directory %s%s%s does not exist.';
  lisUnableToCreateDirectory = 'Unable to create directory %s%s%s.';
  lisUnableToCopyFileTo = 'Unable to copy file %s%s%s%sto %s%s%s';
  lisSorryThisTypeIsNotYetImplemented = 'Sorry, this type is not yet '
    +'implemented';
  lisFileHasChangedSave = 'File %s%s%s has changed. Save?';
  lisUnitHasChangedSave = 'Unit %s%s%s has changed. Save?';
  lisSourceOfPageHasChangedSave = 'Source of page %s%s%s has changed. Save?';
  lisSourceModified = 'Source modified';
  lisOpenProject = 'Open Project?';
  lisOpenTheProject = 'Open the project %s?';
  lisOpenPackage = 'Open Package?';
  lisOpenThePackage = 'Open the package %s?';
  lisRevertFailed = 'Revert failed';
  lisFileIsVirtual = 'File %s%s%s is virtual.';
  lisUnableToWrite = 'Unable to write %s%s%s%s%s.';
  lisFileNotText = 'File not text';
  lisUnableToRenameFile = 'Unable to rename file';
  lisUnableToCopyFile = 'Unable to copy file';
  lisSourceAndDestinationAreTheSame =
    'Source and Destination are the same:%s%s';
  lisUnableToRenameFileTo2 = 'Unable to rename file %s%s%s%sto %s%s%s.';
  lisUnableToCopyFileTo2 = 'Unable to copy file %s%s%s%sto %s%s%s.';
  lisFileDoesNotLookLikeATextFileOpenItAnyway = 'File %s%s%s%sdoes not look '
    +'like a text file.%sOpen it anyway?';
  lisInvalidCommand = 'Invalid command';
  lisTheCommandAfterIsNotExecutable = 'The command after %s%s%s is not '
    +'executable.';
  lisInvalidDestinationDirectory = 'Invalid destination directory';
  lisDestinationDirectoryIsInvalidPleaseChooseAComplete = 'Destination '
    +'directory %s%s%s is invalid.%sPlease choose a complete path.';
  lisUnableToCleanUpDestinationDirectory = 'Unable to clean up destination '
    +'directory';
  lisCommandAfterInvalid = 'Command after invalid';
  lisTheCommandAfterPublishingIsInvalid = 'The command after publishing is '
    +'invalid:%s%s%s%s';
  lisUnableToCleanUpPleaseCheckPermissions = 'Unable to clean up %s%s%s.%'
    +'sPlease check permissions.';
  lisCommandAfterPublishingModule = 'Command after publishing module';
  lisUnableToAddToProjectBecauseThereIsAlreadyAUnitWith = 'Unable to add %s '
    +'to project, because there is already a unit with the same name in the '
    +'Project.';
  lisAddToProject = 'Add %s to project?';
  lisTheFile = 'The file %s%s%s';
  lisAddToUnitSearchPath = 'Add to unit search path?';
  lisTheNewUnitIsNotYetInTheUnitSearchPathAddDirectory = 'The new unit is not '
    +'yet in the unit search path.%sAdd directory %s?';
  lisisAlreadyPartOfTheProject = '%s is already part of the Project.';
  lisRemoveFromProject = 'Remove from project';
  lisCreateAProjectFirst = 'Create a project first!';
  lisTheTestDirectoryCouldNotBeFoundSeeEnvironmentOpt = 'The Test Directory '
    +'could not be found:%s%s%s%s%s(see environment options)';
  lisBuildNewProject = 'Build new project';
  lisTheProjectMustBeSavedBeforeBuildingIfYouSetTheTest = 'The project must '
    +'be saved before building%sIf you set the Test Directory in the '
    +'environment options,%syou can create new projects and build them at '
    +'once.%sSave project?';
  lisProjectSuccessfullyBuilt = 'Project %s%s%s successfully built. :)';
  lisExecutingCommandBefore = 'Executing command before';
  lisExecutingCommandAfter = 'Executing command after';
  lisNoProgramFileSFound = 'No program file %s%s%s found.';
  lisErrorInitializingProgramSErrorS = 'Error initializing program%s%s%s%s%s'
    +'Error: %s';
  lisNotNow = 'Not now';
  lisYouCanNotBuildLazarusWhileDebuggingOrCompiling = 'You can not build '
    +'lazarus while debugging or compiling.';
  lisUnableToSaveFile = 'Unable to save file %s%s%s';
  lisReadError = 'Read Error';
  lisUnableToReadFile2 = 'Unable to read file %s%s%s!';
  lisWriteError = 'Write Error';
  lisUnableToWriteToFile = 'Unable to write to file %s%s%s!';
  lisFileDoesNotLookLikeATextFileOpenItAnyway2 = 'File %s%s%s%sdoes not look '
    +'like a text file.%sOpen it anyway?';
  lisUnableToCreateBackupDirectory =
    'Unable to create backup directory %s%s%s.';
  lisAmbiguousUnitFound2 = 'Ambiguous unit found';
  lisTheUnitExistsTwiceInTheUnitPathOfThe = 'The unit %s exists twice in the '
    +'unit path of the %s:';
  lisHintCheckIfTwoPackagesContainAUnitWithTheSameName = 'Hint: Check if two '
    +'packages contain a unit with the same name.';
  lisIgnoreAll = 'Ignore all';
  lisDeleteFileFailed = 'Delete file failed';
  lisUnableToRemoveOldBackupFile = 'Unable to remove old backup file %s%s%s!';
  lisRenameFileFailed = 'Rename file failed';
  lisUnableToRenameFileTo = 'Unable to rename file %s%s%s to %s%s%s!';
  lisBackupFileFailed = 'Backup file failed';
  lisUnableToBackupFileTo = 'Unable to backup file %s%s%s to %s%s%s!';
  lisFileNotLowercase = 'File not lowercase';
  lisTheUnitIsNotLowercaseTheFreePascalCompiler = 'The unit filename %s%s%s is '
    +'not lowercase.%sThe FreePascal compiler does not search for all cases.'
    +' It is recommended to use lowercase filename.%s%sRename file lowercase?';
  lisDeleteAmbiguousFile = 'Delete ambiguous file?';
  lisAmbiguousFileFoundThisFileCanBeMistakenWithDelete = 'Ambiguous file '
    +'found: %s%s%s%sThis file can be mistaken with %s%s%s%s%sDelete the '
    +'ambiguous file?';
  lisLazarusEditorV = 'Lazarus IDE v%s';
  lisnewProject = '%s - (new project)';
  liscompiling = '%s (compiling ...)';
  lisdebugging = '%s (debugging ...)';
  lisUnableToFindFile = 'Unable to find file %s%s%s.';
  lisUnableToFindFileCheckSearchPathInProjectCompilerOption = 'Unable to find '
    +'file %s%s%s.%sIf it belongs to your project, check search path '
    +'in%sProject->Compiler Options...->Search Paths->Other Unit Files.'
    +' If this file belongs to a package, check the appropriate package compiler'
    +' options. If this file belongs to lazarus, make sure compiling clean.'
    +' If the file belongs to FPC then check fpc.cfg.'
    +' If unsure, check Project -> CompilerOptions ... -> Test';
  lisNOTECouldNotCreateDefineTemplateForFreePascal = 'NOTE: Could not create '
    +'Define Template for Free Pascal Sources';
  lisClassNotFound = 'Class not found';
  lisOIFClassNotFound = 'Class %s%s%s not found.';
  lisClassIsNotARegisteredComponentClassUnableToPaste = 'Class %s%s%s is not '
    +'a registered component class.%sUnable to paste.';
  lisControlNeedsParent = 'Control needs parent';
  lisTheClassIsATControlAndCanNotBePastedOntoANonContro = 'The class %s%s%s '
    +'is a TControl and can not be pasted onto a non control.%sUnable to paste.';
  lisConversionError = 'Conversion error';
  lisUnableToConvertComponentTextIntoBinaryFormat = 'Unable to convert '
    +'component text into binary format:%s%s';
  lisNOTECouldNotCreateDefineTemplateForLazarusSources = 'NOTE: Could not '
    +'create Define Template for Lazarus Sources';
  lisInvalidExpressionHintTheMakeResourcestringFunction = 'Invalid expression.%'
    +'sHint: The "Make Resourcestring" function expects a string constant in a '
    +'single file. Please select the expression and try again.';
  lisSelectionExceedsStringConstant = 'Selection exceeds string constant';
  lisHintTheMakeResourcestringFunctionExpectsAStringCon2 = 'Hint: The "Make '
    +'Resourcestring" function expects a string constant.%sPlease select only '
    +'a string expression and try again.';
  lisNoResourceStringSectionFound = 'No ResourceString Section found';
  lisUnableToFindAResourceStringSectionInThisOrAnyOfThe = 'Unable to find a '
    +'ResourceString section in this or any of the used units.';
  lisComponentNameIsNotAValidIdentifier = 'Component name %s%s%s is not a '
    +'valid identifier';
  lisDuplicateNameAComponentNamedAlreadyExistsInTheInhe = 'Duplicate name: A '
    +'component named %s%s%s already exists in the inherited component %s';
  lisComponentNameIsKeyword = 'Component name %s%s%s is keyword';
  lisTheUnitItselfHasAlreadyTheNamePascalIdentifiersMus = 'The unit itself '
    +'has already the name %s%s%s. Pascal identifiers must be unique.';
  lisUnableToRenameVariableInSource = 'Unable to rename variable in source.';
  lisUnableToUpdateCreateFormStatementInProjectSource = 'Unable to update '
    +'CreateForm statement in project source';
  lisThereIsAlreadyAFormWithTheName = 'There is already a form with the name %'
    +'s%s%s';
  lisThereIsAlreadyAUnitWithTheNamePascalIdentifiersMus = 'There is already a '
    +'unit with the name %s%s%s. Pascal identifiers must be unique.';
  lisSeeMessages = 'See messages.';
  lisError = 'Error: ';
  lisSaveChanges = 'Save changes?';
  lisSaveFileBeforeClosingForm =
    'Save file %s%s%s%sbefore closing form %s%s%s?';
  lisUnableToRenameFormInSource = 'Unable to rename form in source.';
  lisSorryNotImplementedYet = 'Sorry, not implemented yet';
  lisUnableToFindMethodPleaseFixTheErrorShownInTheMessage = 'Unable to find '
    +'method. Please fix the error shown in the message window.';
  lisUnableToCreateNewMethodPleaseFixTheErrorShownIn = 'Unable to create new '
    +'method. Please fix the error shown in the message window.';
  lisUnableToShowMethodPleaseFixTheErrorShownInTheMessage = 'Unable to show '
    +'method. Please fix the error shown in the message window.';
  lisMethodClassNotFound = 'Method class not found';
  lisClassOfMethodNotFound = 'Class %s%s%s of method %s%s%s not found.';
  lisUnableToRenameMethodPleaseFixTheErrorShownInTheMessag = 'Unable to rename '
    +'method. Please fix the error shown in the message window.';
  lisStopDebugging = 'Stop Debugging?';
  lisStopTheDebugging = 'Stop the debugging?';
  lisCannotFindLazarusStarter = 'Cannot find lazarus starter:%s%s';
  lisInfoBuildLines  = 'Lines:';
  lisInfoBuildErrors = 'Errors:';
  lisInfoBuildHint = 'Hints:';
  lisInfoBuildWarning = 'Warnings:';
  lisInfoBuildBuild   = 'Build';
  lisInfoBuildComplile = 'Compiling...';
  lisInfoBuildError = 'Error...';
  lisCreateDirectory = 'Create directory?';
  lisTheOutputDirectoryIsMissing = 'The output directory %s%s%s is missing.';
  lisCreateIt = 'Create it';
  lisInfoBuildSuccess = 'Success...';
  lisInfoBuildAbort = 'Aborted...';
  lisInfoBuildCaption = 'Compile Project';
  lisInfoBuildMakeAbort = 'Abort';
  lisInfoBuildNote = 'Notes:';

  // resource files
  lisResourceFileComment =
    'This is an automatically generated lazarus resource file';

  // file dialogs
  lisOpenFile = 'Open file';
  lisPEEditVirtualUnit = 'Edit Virtual Unit';
  lisIECOExportFileExists = 'Export file exists';
  lisIECOExportFileExistsOpenFileAndReplaceOnlyCompilerOpti = 'Export file %s%'
    +'s%s exists.%sOpen file and replace only compiler options?%s(Other '
    +'settings will be kept.)';
  lisIECOOpenOrLoadCompilerOptions = 'Open or Load Compiler Options';
  lisIECOErrorAccessingXml = 'Error accessing xml';
  lisIECOErrorLoadingXml = 'Error loading xml';
  lisIECOErrorLoadingXmlFile = 'Error loading xml file %s%s%s:%s%s';
  lisIECOErrorAccessingXmlFile = 'Error accessing xml file %s%s%s:%s%s';
  lisIECORecentFiles = 'Recent files';
  lisIECOSaveToRecent = 'Save to recent';
  lisIECOOpenRecent = 'Open recent';
  lisIECOSaveToFile = 'Save to file';
  lisIECOLoadFromFile = 'Load from file';
  lisLazarusFile = 'Lazarus File';
  lisPascalUnit = 'Pascal unit';
  lisPascalSourceFile = 'Pascal source file';
  lisFreePascalSourceFile = 'FreePascal source file';
  lisDebugUnableToLoadFile = 'Unable to load file';
  lisDebugUnableToLoadFile2 = 'Unable to load file %s%s%s.';
  lisOpenProjectFile = 'Open Project File';
  lisLazarusProjectInfoFile = 'Lazarus Project Info file';
  lisAllFiles = 'All Files';
  lisExePrograms = 'Programs';
  lisSelectFile = 'Select the file';
  lisClickHereToBrowseTheFileHint = 'Click here to browse the file';
  lisProjectWizard = 'Project Wizard';
  lisQuitLazarus = 'Quit Lazarus';
  lisCreateNewProject = 'Create new project';
  lisOpenPackageFile = 'Open Package File';
  lisSaveSpace = 'Save ';
  lisSelectDFMFiles = 'Select Delphi form files (*.dfm)';
  lisChooseDirectory = 'Choose directory';
  lisDestinationDirectory = 'Destination directory';
  lisCommandAfter = 'Command after';
  lisChooseLazarusSourceDirectory = 'Choose Lazarus Directory';
  lisChooseCompilerPath = 'Choose compiler filename (%s)';
  lisChooseFPCSourceDir = 'Choose FPC source directory';
  lisChooseMakePath = 'Choose make path';
  lisChooseDebuggerPath = 'Choose debugger filename';
  lisChooseTestBuildDir = 'Choose the directory for tests';
  lisLazarusDesktopSettings = 'Lazarus Desktop Settings';
  lisXMLFiles = 'XML files';

  // dialogs
  lisSaveChangesToProject = 'Save changes to project %s?';
  lisProjectChanged = 'Project changed';

  lisFPCSourceDirectoryError = 'FPC Source Directory error';
  lisPleaseCheckTheFPCSourceDirectory = 'Please check the freepascal source directory';
  lisCompilerError = 'Compiler error';
  lisPleaseCheckTheCompilerName = 'Please check the compiler name';
  lisAboutLazarus = 'About Lazarus';
  lisVersion = 'Version';
  lisVerToClipboard = 'Copy version information to clipboard';
  lisLogo = 'Logo';
  lisDate = 'Date';
  lisFPCVersion = 'FPC Version: ';
  lisSVNRevision = 'SVN Revision: ';
  lisClose = '&Close';
  lisAboutLazarusMsg =
       'License: GPL/LGPL'
      +'%s'
      +'Lazarus is an IDE to create (graphical and console) applications '
      +'with Free Pascal. Free Pascal is a (L)GPL''ed Pascal and Object Pascal '
      +'compiler that runs on Windows, Linux, Mac OS X, FreeBSD and more.'
      +'%s'
      +'Lazarus is the missing part of the puzzle that will allow you to '
      +'develop programs for all of the above platforms in a Delphi like '
      +'environment. The IDE is a RAD tool that includes a form designer.'
      +'%s'
      +'As Lazarus is growing we need more developers.';
  lisAboutNoContributors = 'Cannot find contributors list.';
  lisUnitNameAlreadyExistsCap = 'Unitname already in project';
  lisTheUnitAlreadyExistsIgnoreWillForceTheRenaming = 'The unit %s%s%s '
    +'already exists.%sIgnore will force the renaming,%sCancel will cancel '
    +'the saving of this source and%sAbort will abort the whole saving.';
  lisForceRenaming = 'Force renaming';
  lisCancelRenaming = 'Cancel renaming';
  lisAbortAll = 'Abort all';
  lisInvalidPascalIdentifierCap = 'Invalid Pascal Identifier';
  lisInvalidPascalIdentifierText =
    'The name "%s" is not a valid pascal identifier.';
  lisCopyError = 'Copy Error';

  // hints
  lisHintOpen = 'Open';
  lisHintSave = 'Save';
  lisHintSaveAll = 'Save all';
  lisHintToggleFormUnit = 'Toggle Form/Unit';
  lisHintViewUnits = 'View Units';
  lisHintViewForms = 'View Forms';
  lisHintRun = 'Run';
  lisHintPause = 'Pause';
  lisHintStop = 'Stop';
  lisHintStepInto = 'Step Into';
  lisHintStepOver = 'Step Over';
  
  lisGPLNotice =
    '<description>'
   +'%s'
   +'Copyright (C) <year> <name of author> <contact>'
   +'%s'
   +'This source is free software; you can redistribute it and/or modify '
   +'it under the terms of the GNU General Public License as published by '
   +'the Free Software Foundation; either version 2 of the License, or '
   +'(at your option) any later version. '
   +'%s'
   +'This code is distributed in the hope that it will be useful, but '
   +'WITHOUT ANY WARRANTY; without even the implied warranty of '
   +'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU '
   +'General Public License for more details. '
   +'%s'
   +'A copy of the GNU General Public License is available on the World '
   +'Wide Web at <http://www.gnu.org/copyleft/gpl.html>. You can also '
   +'obtain it by writing to the Free Software Foundation, '
   +'Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.';

  lisLGPLNotice =
    '<description>'
   +'%s'
   +'Copyright (C) <year> <name of author> <contact>'
   +'%s'
   +'This library is free software; you can redistribute it and/or modify '
   +'it under the terms of the GNU Library General Public License as published '
   +'by the Free Software Foundation; either version 2 of the License, or '
   +'(at your option) any later version. '
   +'%s'
   +'This program is distributed in the hope that it will be useful, '
   +'but WITHOUT ANY WARRANTY; without even the implied warranty of '
   +'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the '
   +'GNU Library General Public License for more details. '
   +'%s'
   +'You should have received a copy of the GNU Library General Public License '
   +'along with this library; if not, write to the Free Software '
   +'Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.';

  lisModifiedLGPLNotice =
    '<description>'
   +'%s'
   +'Copyright (C) <year> <name of author> <contact>'
   +'%s'
   +'This library is free software; you can redistribute it and/or modify '
   +'it under the terms of the GNU Library General Public License as published '
   +'by the Free Software Foundation; either version 2 of the License, or '
   +'(at your option) any later version with the following modification:'
   +'%s'
   +'As a special exception, the copyright holders of this library give you '
   +'permission to link this library with independent modules to produce an '
   +'executable, regardless of the license terms of these independent modules,'
   +'and to copy and distribute the resulting executable under terms of your '
   +'choice, provided that you also meet, for each linked independent module, '
   +'the terms and conditions of the license of that module. An independent '
   +'module is a module which is not derived from or based on this library. If '
   +'you modify this library, you may extend this exception to your version of '
   +'the library, but you are not obligated to do so. If you do not wish to do '
   +'so, delete this exception statement from your version.'
   +'%s'
   +'This program is distributed in the hope that it will be useful, '
   +'but WITHOUT ANY WARRANTY; without even the implied warranty of '
   +'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the '
   +'GNU Library General Public License for more details. '
   +'%s'
   +'You should have received a copy of the GNU Library General Public License '
   +'along with this library; if not, write to the Free Software '
   +'Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.';

  // Options dialog groups
  dlgGroupEnvironment = 'Environment';
  dlgGroupEditor = 'Editor';
  dlgGroupCodetools = 'Codetools';
  dlgGroupCodeExplorer = 'Code Explorer';
  dlgGroupDebugger = 'Debugger';
  dlgGroupHelp = 'Help';

  // Options dialog
  dlgBakNoSubDirectory = '(no subdirectory)';
  dlgEOFocusMessagesAfterCompilation = 'Focus messages after compilation';
  
  // Search dialog
  dlgSearchCaption = 'Searching...';
  dlgSearchAbort = 'Search terminated by user.';
  dlgSeachDirectoryNotFound = 'Search directory "%s" not found.';
  lissMatches = 'Matches';
  lissSearching = 'Searching';
  lissSearchText = 'Search text';

  dlgDesktop = 'Desktop';
  dlgWindow = 'Window';
  dlgFrmEditor = 'Form Editor';
  dlgObjInsp = 'Object Inspector';
  dlgEnvFiles = 'Files';
  lisIgnoreBinaries = 'Ignore binaries';
  lisSimpleSyntax = 'Simple Syntax';
  lisNormallyTheFilterIsARegularExpressionInSimpleSynta = 'Normally the '
    +'filter is a regular expression. In Simple Syntax a . is a normal '
    +'character, a * stands for anything, a ? stands for any character, and '
    +'comma and semicolon separates alternatives. For example: Simple '
    +'Syntax *.pas;*.pp corresponds to ^(.*\.pas|.*\.pp)$';
  lisUseExcludeFilter = 'Use Exclude Filter';
  lisExcludeFilter = 'Exclude Filter';
  lisProjectInformation = 'Project Information';
  lisSaveEditorInfoOfNonProjectFiles = 'Save editor info of non project files';
  lisSaveInfoOfClosedEditorFiles = 'Save info of closed editor files';
  lisUseIncludeFilter = 'Use Include Filter';
  lisIncludeFilter = 'Include Filter';
  dlgEnvBckup = 'Backup';
  dlgNaming = 'Naming';
  lisFPDocEditor = 'FPDoc Editor';
  dlgCancel = 'Cancel';
  lisSAMSelectNone = 'Select none';
  lisKMClassic = 'Classic';
  lisKMLazarusDefault = 'Lazarus (default)';
  lisKMMacOSXApple = 'Mac OS X (Apple style)';
  lisKMMacOSXLaz = 'Mac OS X (Lazarus style)';
  lisPEFilename = 'Filename:';
  lisPEUnitname = 'Unitname:';
  lisPVUTheUnitnameIsUsedWhenTheIDEExtendsUsesClauses = 'The unitname is used '
    +'when the IDE extends uses clauses.';
  lisPETheUnitnameIsUsedWhenTheIDEExtendsUsesClauses = 'The unitname is used '
    +'when the IDE extends uses clauses.';
  lisPEInvalidUnitFilename = 'Invalid unit filename';
  lisPVUAPascalUnitMustHaveTheExtensionPpOrPas = 'A pascal unit must have the '
    +'extension .pp or .pas';
  lisPEAPascalUnitMustHaveTheExtensionPpOrPas = 'A pascal unit must have the '
    +'extension .pp or .pas';
  lisPEInvalidUnitname = 'Invalid unitname';
  lisPVUTheUnitnameIsNotAValidPascalIdentifier = 'The unitname is not a valid '
    +'pascal identifier.';
  lisPVUUnitnameAndFilenameDoNotMatchExampleUnit1PasAndUni = 'Unitname and '
    +'Filename do not match.%sExample: unit1.pas and Unit1';
  lisPETheUnitnameIsNotAValidPascalIdentifier = 'The unitname is not a valid '
    +'pascal identifier.';
  lisPEConflictFound = 'Conflict found';
  lisPVUThereIsAlreadyAnUnitWithThisNameFile = 'There is already an unit with '
    +'this name.%sFile: %s';
  lisPEThereIsAlreadyAnUnitWithThisNameFile = 'There is already an unit with '
    +'this name.%sFile: %s';
  lisPEUnitnameAndFilenameDoNotMatchExampleUnit1PasAndUni = 'Unitname and '
    +'Filename do not match.%sExample: unit1.pas and Unit1';
  lisOk = '&Ok';
  lisCMParameter = 'Parameter';
  lisCTPleaseSelectAMacro = 'please select a macro';
  lisA2PCreateNewFile = 'Create new file';
  dlgEnvLanguage = 'Language';
  dlgAutoSave = 'Auto save';
  dlgEdFiles = 'Editor files';
  dlgEnvProject = 'Project';
  lisNumberOfFilesToConvert = 'Number of files to convert: %s';
  lisConvertEncoding = 'Convert encoding';
  lisConvertProjectOrPackage = 'Convert project or package';
  lisNewEncoding = 'New encoding:';
  lisFileFilter = 'File filter';
  lisFilesInASCIIOrUTF8Encoding = 'Files in ASCII or UTF-8 encoding';
  lisFilesNotInASCIINorUTF8Encoding = 'Files not in ASCII nor UTF-8 encoding';
  podAddPackageUnitToUsesSection = 'Add package unit to uses section';
  lisCodeBrowser = 'Code browser';
  dlgIntvInSec = 'Interval in secs';
  dlgDesktopFiles = 'Desktop files';
  dlgSaveDFile = 'Save desktop settings to file';
  dlgLoadDFile = 'Load desktop settings from file';
  dlgMinimizeAllOnMinimizeMain = 'Minimize all on minimize main';
  dlgHideIDEOnRun = 'Hide IDE windows on run';
  dlgHideMessagesIcons = 'Hide Messages Icons';
  dlgDesktopHints = 'Hints';
  dlgPalHints = 'Hints for component palette';
  dlgSpBHints = 'Hints for main speed buttons (open, save, ...)';
  dlgDesktopGlyphsFor = 'Glyphs for:';
  dlgDesktopButtons = 'Buttons - ';
  dlgDesktopMenus = 'Menus - ';
  dlgGlyphShowAlways = 'Show Always';
  dlgGlyphShowNever = 'Show Never';
  dlgGlyphShowSystem = 'Use System Defaults';

  dlgDesktopMisc = 'Misc Options';

  lisCheckChangesOnDiskWithLoading = 'Check changes on disk with loading';

  lisEnvDoubleClickOnMessagesJumpsOtherwiseSingleClick = 'Double click on '
    +'messages jumps (otherwise: single click)';
  dlgWinPos = 'Window Positions';
  dlgMainMenu = 'Main Menu';
  dlgSrcEdit = 'Source Editor';
  dlgMsgs = 'Messages';
  dlgProjFiles = 'Project files';
  dlgEnvType = 'Type';
  dlgEnvNone = 'None';
  lisLeft = 'Left';
  dlgSmbFront = 'Symbol in front (.~pp)';
  lisNoBackupFiles = 'No backup files';
  dlgSmbBehind = 'Symbol behind (.pp~)';
  dlgSmbCounter = 'Counter (.pp;1)';
  dlgCustomExt = 'User defined extension (.pp.xxx)';
  dlgBckUpSubDir = 'Same name (in subdirectory)';
  dlgEdCustomExt = 'User defined extension';
  dlgMaxCntr = 'Maximum counter';
  dlgEdBSubDir = 'Sub directory';
  dlgEnvOtherFiles = 'Other files';
  dlgMaxRecentFiles = 'Max recent files';
  dlgMaxRecentProjs = 'Max recent project files';
  dlgQOpenLastPrj = 'Open last project at start';
  dlgQShowCompileDialog = 'Show compile dialog';
  dlgLazarusDir = 'Lazarus directory (default for all projects)';
  dlgFpcPath = 'Compiler path (e.g. %s)';
  dlgFpcSrcPath = 'FPC source directory';
  dlgMakePath = 'Make path';
  dlgDebugType = 'Debugger type and path';
  dlgTestPrjDir = 'Directory for building test projects';
  dlgQShowGrid = 'Show grid';
  dlgQShowBorderSpacing = 'Show border spacing';
  dlgGridColor = 'Grid color';
  dlgQSnapToGrid = 'Snap to grid';
  dlgGridX = 'Grid size X';
  dlgGridXHint = 'Horizontal grid step size';
  dlgGridY = 'Grid size Y';
  dlgGridYHint = 'Vertical grid step size';
  dlgGuideLines = 'Show Guide Lines';
  dlgSnapGuideLines = 'Snap to Guide Lines';
  dlgLeftTopClr = 'color for left, top';
  dlgRightBottomClr = 'color for right, bottom';
  dlgShowCaps = 'Show component captions';
  dlgShowEdrHints = 'Show editor hints';
  dlgAutoForm = 'Auto create form when opening unit';
  dlgrightClickSelects = 'Right Click selects';
  dlgGrabberColor = 'Grabber color';
  dlgMarkerColor = 'Marker color';
  lisFEPaintDesignerItemsOnIdle = 'Reduce designer painting';
  lisFEPaintDesignerItemsOnIdleReduceOverheadForSlowCompu = 'Paint designer '
    +'items only on idle (reduce overhead for slow computers)';
  dlgEnvGrid = 'Grid';
  dlgEnvLGuideLines = 'Guide lines';
  dlgEnvMisc = 'Miscellaneous';
  dlgRuberbandSelectionColor = 'Selection';
  dlgRuberbandCreationColor = 'Creation';
  dlgRubberbandSelectsGrandChilds = 'Select grand childs';
  dlgRubberBandGroup='Rubber band';
  dlgPasExt = 'Default pascal extension';
  dlgCharCaseFileAct = 'Save As - auto rename pascal files lower case';
  
  dlgAmbigFileAct = 'Ambiguous file action:';
  dlgEnvAsk = 'Ask';
  lisNever = 'Never';
  dlgAutoDel = 'Auto delete file';
  dlgAutoRen = 'Auto rename file lowercase';
  dlgnoAutomaticRenaming = 'no automatic renaming';
  lisWhenAUnitIsRenamedUpdateReferences = 'When a unit is renamed, update '
    +'references ...';
  lisAlways = 'Always';
  dlgAmbigWarn = 'Warn on compile';
  dlgIgnoreVerb = 'Ignore';
  // OI colors
  dlgBackColor = 'Background';
  dlgSubPropColor = 'SubProperties';
  dlgReferenceColor = 'Reference';
  dlgValueColor = 'Value';
  dlgHighlightColor = 'Highlight Color';
  dlgHighlightFontColor = 'Highlight Font Color';
  dlgDefValueColor = 'Default Value';
  dlgPropNameColor = 'Property Name';
  dlgGutterEdgeColor = 'Gutter Edge Color';

  liswlAdd = '&Add';
  liswlProperties = '&Properties';
  liswlEnabled = '&Enabled';
  liswlDelete = '&Delete';
  liswlDIsableAll = 'D&isable All';
  liswlENableAll = 'E&nable All';
  liswlDeLeteAll = 'De&lete All';

  dlgOIMiscellaneous = 'Miscellaneous';
  dlgOISpeedSettings = 'Speed settings';
  dlgOIOptions = 'Options';
  dlgOIItemHeight = 'Item height';
  dlgOIUseDefaultLazarusSettings = 'Use default Lazarus settings';
  dlgOIUseDefaultDelphiSettings = 'Use default Delphi settings';
  lisShowHintsInObjectInspector = 'Show hints';
  lisAutoShowObjectInspector = 'Auto show';
  lisBoldNonDefaultObjectInspector = 'Bold non default values';
  lisDrawGridLinesObjectInspector = 'Draw grid lines';
  lisShowGutterInObjectInspector = 'Show gutter';
  lisShowStatusBarInObjectInspector = 'Show status bar';
  lisShowInfoBoxInObjectInspector = 'Show information box';
  dlgEnvColors = 'Colors';
  dlgEnvBackupHelpNote =
    'Notes: Project files are all files in the project directory';
  lisEnvOptDlgInvalidCompilerFilename = 'Invalid compiler filename';
  lisEnvOptDlgInvalidCompilerFilenameMsg =
    'The compiler file "%s" is not an executable.';
  lisEnvOptDlgInvalidMakeFilename = 'Invalid make filename';
  lisEnvOptDlgInvalidMakeFilenameMsg =
    'The make file "%s" is not an executable.';
  lisEnvOptDlgInvalidDebuggerFilename = 'Invalid debugger filename';
  lisEnvOptDlgInvalidDebuggerFilenameMsg =
    'The debugger file "%s" is not an executable.';
  lisEnvOptDlgDirectoryNotFound = 'Directory not found';
  lisTheDirectoryWasNotFound = 'The directory %s was not found.';
  lisInstallationFailed = 'Installation failed';
  lisPkgMangThePackageFailedToCompileRemoveItFromTheInstallati = 'The package %'
    +'s%s%s failed to compile.%sRemove it from the installation list?';
  lisEnvOptDlgLazarusDirNotFoundMsg = 'Lazarus directory "%s" not found.';
  lisEnvOptDlgInvalidLazarusDir = 'The lazarus directory "%s" does not look correct.'
    +' Normally it contains directories like lcl, debugger, designer, components, ... .';
  lisEnvOptDlgFPCSrcDirNotFoundMsg = 'FPC source directory "%s" not found.';
  lisEnvOptDlgInvalidFPCSrcDir = 'The FPC source directory "%s" does not look correct.'
    +' Normally it contains directories like rtl, packages, compiler, ... .';
  lisEnvOptDlgTestDirNotFoundMsg = 'Test directory "%s" not found.';

  // editor options
  dlgEdMisc = 'Misc';
  dlgEdDisplay = 'Display';
  lisEOTabWidths = 'Tab widths';
  dlgKeyMapping = 'Key Mappings';
  dlgEdColor = 'Colors';
  dlgKeyMappingErrors = 'Key mapping errors';
  dlgEdBack = 'Back';
  dlgReport = 'Report';
  dlgEdNoErr = 'No errors in key mapping found.';
  dlgDelTemplate = 'Delete template ';
  dlgChsCodeTempl = 'Choose code template file (*.dci)';
  dlgAllFiles = 'All files';
  lisOld = 'old';
  lisNew = 'new';
  lisRemove = 'remove';
  lisConfirmNewPackageSetForTheIDE = 'Confirm new package set for the IDE';
  lisThisWillHappenContinue = 'This will happen:%s%s%sContinue?';
  lisSaveFileAs = 'Save file as';
  lisOpenExistingFile = 'Open existing file';
  lisLazarusUnit = 'Lazarus unit';
  lisLazarusInclude = 'Lazarus include file';
  lisLazarusProject = 'Lazarus project';
  lisLazarusForm = 'Lazarus form';
  lisLazarusPackage = 'Lazarus package';
  lisLazarusProjectSource = 'Lazarus project source';

  dlgUndoGroupOptions = 'Undo / Redo:';
  dlgScrollGroupOptions = 'Scrolling:';
  dlgIndentsTabsGroupOptions = 'Indent and Tabs:';
  dlgMouseGroupOptions = 'Mouse:';
  dlgCursorGroupOptions = 'Cursor:';
  dlgAlwaysVisibleCursor = 'Always visible cursor';
  dlgAutoIndent = 'Auto indent';
  dlgDropFiles = 'Drop files';
  dlgGroupUndo = 'Group Undo';
  dlgHalfPageScroll = 'Half page scroll';
  dlgKeepCursorX = 'Keep cursor X position';
  dlgPersistentCursor = 'Persistent cursor';
  dlgCursorSkipsSelection = 'Cursor skips selection';
  dlgScrollByOneLess = 'Scroll by one less';
  dlgScrollPastEndFile = 'Scroll past end of file';
  dlgScrollPastEndLine = 'Caret past end of line';
  lisShowSpecialCharacters = 'Show special characters';
  dlgCloseButtonsNotebook = 'Show close buttons in notebook';
  dlgShowScrollHint = 'Show scroll hint';
  dlgShowGutterHints = 'Show gutter hints';
  dlgSmartTabs = 'Smart tabs';
  dlgTabsToSpaces = 'Tabs to spaces';
  dlgTabIndent = 'Tab indents blocks';
  dlgTrimTrailingSpaces = 'Trim trailing spaces';
  dlgUndoAfterSave = 'Undo after save';
  dlgFindTextatCursor = 'Find text at cursor';
  dlgUseSyntaxHighlight = 'Use syntax highlight';
  dlgUseCodeFolding = 'Code folding';
  dlgCodeFoldingMouse = 'Mouse';
  dlgMouseOptions = 'Mouse';
  dlgMouseOptNodeMain = 'Text';
  dlgMouseOptNodeSelect = 'Selection';
  dlgMouseOptNodeGutter = 'Gutter';
  dlgMouseOptNodeGutterFold = 'Fold Tree';
  dlgMouseOptNodeGutterFoldCol = 'Collapsed [+]';
  dlgMouseOptNodeGutterFoldExp = 'Expanded [-]';
  dlgMouseOptNodeGutterLines = 'Line Numbers';
  dlgMouseOptHeadDesc = 'Action';
  dlgMouseOptHeadBtn = 'Button';
  dlgMouseOptHeadCount = 'Click';
  dlgMouseOptHeadDir = 'Up/Down';
  dlgMouseOptHeadShift = 'Shift';
  dlgMouseOptHeadAlt = 'Alt';
  dlgMouseOptHeadCtrl = 'Ctrl';
  dlgMouseOptHeadCaret = 'Caret';
  dlgMouseOptHeadPriority = 'Priority';
  dlgMouseOptHeadOpt = 'Option';
  dlgMouseOptBtnLeft   = 'Left';
  dlgMouseOptBtnMiddle = 'Middle';
  dlgMouseOptBtnRight  = 'Right';
  dlgMouseOptBtnExtra1 = 'Extra 1';
  dlgMouseOptBtnExtra2 = 'Extra 2';
  dlgMouseOptBtnDown = 'Down';
  dlgMouseOptBtnUp   = 'Up';
  dlgMouseOptBtn1   = 'Single';
  dlgMouseOptBtn2   = 'Double';
  dlgMouseOptBtn3   = 'Triple';
  dlgMouseOptBtn4   = 'Quad';
  dlgMouseOptBtnAny = 'Any';
  dlgMouseOptMoveMouseTrue   = 'Y';
  dlgMouseOptMoveMouseFalse  = '';
  dlgMouseOptModKeyFalse   = 'n';
  dlgMouseOptModKeyTrue    = 'Y';
  dlgMouseOptModKeyIgnore  = '-';
  dlgMouseOptCheckUpDown   = 'Act on Mouse up';
  dlgMouseOptModShift = 'Shift';
  dlgMouseOptModAlt   = 'Alt';
  dlgMouseOptModCtrl  = 'Ctrl';
  dlgMouseOptBtnDel  = 'Delete';
  dlgMouseOptBtnUdp  = 'Change';
  dlgMouseOptBtnAdd  = 'Add';
  dlgMouseOptBtnImport = 'Import';
  dlgMouseOptBtnExport = 'Export';
  dlgMouseOptBtnOk  = 'Ok';
  dlgMouseOptBtnCancel  = 'Cancel';
  dlgMouseOptBtnModDef = 'Make Fallback';
  dlgMouseOptPriorLabel = 'Priority';
  dlgMouseOptDlgTitle = 'Edit Mouse';
  dlgMouseOptCapture = 'Capture';
  dlgMouseOptCaretMove = 'Move Caret (extra)';
  dlgMouseOptErrorDup = 'Duplicate Entry';
  dlgMouseOptErrorDupText = 'This entry conflicts with an existing entry';
  dlgMouseOptDescAction = 'Action';
  dlgMouseOptDescButton = 'Click';
  dlgMouseOptionsynCommand = 'IDE-Command';
  dlgUseDividerDraw = 'Divider drawing';
  dlgCopyWordAtCursorOnCopyNone = 'Copy word on copy none';
  dlgHomeKeyJumpsToNearestStart = 'Home key jumps to nearest start';
  dlgEndKeyJumpsToNearestStart = 'End key jumps to nearest end';
  dlgBracketHighlight = 'Bracket highlight';
  dlgNoBracketHighlight = 'No Highlight';
  dlgHighlightLeftOfCursor = 'Left Of Cursor';
  dlgHighlightRightOfCursor = 'Right Of Cursor';
  gldHighlightBothSidesOfCursor = 'On Both Sides';
  dlgBlockIndent = 'Block indent';
  dlgBlockIndentType = 'Indent method';
  dlgBlockIndentTypeSpace = 'Spaces';
  dlgBlockIndentTypeCopy = 'Space/tab as prev Line';
  dlgBlockIndentTypePos = 'Position only';
  dlgTrimSpaceTypeCaption = 'Trim Spaces Style';
  dlgTrimSpaceTypeLeaveLine = 'Leave line';
  dlgTrimSpaceTypeEditLine = 'Line Edited';
  dlgTrimSpaceTypeCaretMove = 'Caret or Edit';
  dlgTrimSpaceTypePosOnly = 'Position Only';
  dlgCopyPasteKeepFolds = 'Copy/Paste with fold info';
  dlgUndoLimit = 'Undo limit';
  dlgTabWidths = 'Tab widths';
  dlgMarginGutter = 'Margin and gutter';
  dlgVisibleRightMargin = 'Visible right margin';
  dlgVisibleGutter = 'Visible gutter';
  dlgGutterSeparatorIndex = 'Gutter separator index';
  dlgShowLineNumbers = 'Show line numbers';
  dlgShowCompilingLineNumbers = 'Show line numbers';
  dlgRightMargin = 'Right margin';
  dlgGutter = 'Gutter';
  dlgGutterWidth = 'Gutter width';
  dlgGutterColor = 'Gutter Color';
  dlgEditorFont = 'Editor font';
  dlgDefaultEditorFont='Default editor font';
  dlgEditorFontHeight = 'Editor font height';
  dlgExtraCharSpacing = 'Extra char spacing';
  dlgExtraLineSpacing = 'Extra line spacing';
  dlgDisableAntialiasing = 'Disable anti-aliasing';
  dlgKeyMappingScheme = 'Key Mapping Scheme';
  dlgCheckConsistency = 'Check consistency';
  lisEdOptsChooseScheme = 'Choose Scheme';
  dlgEdHintCommand = 'Hint: click on the command you want to edit';
  dlgLang = 'Language';
  dlgClrScheme = 'Color Scheme';
  dlgFileExts = 'File extensions';
  dlgSetElementDefault = 'Set element to default';
  dlgSetAllElementDefault = 'Set all elements to default';
  dlgColor = 'Color';
  dlgForecolor = 'Foreground';
  dlgFrameColor = 'Frame color';
  dlgUnsavedLineColor = 'Unsaved line';
  dlgSavedLineColor = 'Saved line';
  dlgEdUseDefColor = 'Use default color';
  dlgElementAttributes = 'Element Attributes';
  dlgEdBold = 'Bold';
  dlgEdItal = 'Italic';
  dlgEdUnder = 'Underline';
  dlgEdOn = 'On';
  dlgEdOff = 'Off';
  dlgEdInvert = 'Invert';
  dlgEdIdComlet = 'Identifier completion';
  dlgEdCompleteBlocks = 'Complete blocks';
  dlgTooltipEval = 'Tooltip expression evaluation';
  dlgTooltipTools = 'Tooltip symbol Tools';
  dlgMarkupWordFull = 'Current Word match word boundaries';
  dlgMarkupWordFullLen = 'Only if shorter than';
  dlgMarkupWordNoKeyword = 'Ignore Keywords';
  dlgMarkupWordTrim = 'Trim Spaces';
  dlgMarkupWordNoTimer = 'Disable Timer for Markup Current Word';
  dlgAutoRemoveEmptyMethods = 'Auto remove empty methods';
  dlgEdDelay = 'Delay';
  dlgTimeSecondUnit = 'sec';
  dlgEdCodeTempl = 'Code templates';
  dlgTplFName = 'Template file name';
  dlgEdAdd = 'Add...';
  dlgEdEdit = 'Edit...';
  dlgEdDelete = 'Delete';
  dlgIndentCodeTo = 'Indent code to';
  //dlgCodeToolsTab = 'Code Tools';
  lisAutomaticFeatures = 'Automatic features';

  dlgDividerOnOff = 'Draw divider';
  dlgDividerDrawDepth = 'Draw divider level';
  dlgDividerTopColor = 'Line color';
  dlgDividerTopColorDefault = 'Use Default';
  dlgDividerNestColor = 'Nested line color';
  dlgDividerNestColorDefault = 'Use Default';

  dlgDivPasUnitSectionName  = 'Unit sections';
  dlgDivPasUsesName         = 'Uses clause';
  dlgDivPasVarGlobalName    = 'Var/Type';
  dlgDivPasVarLocalName     = 'Var/Type (local)';
  dlgDivPasStructGlobalName = 'Class/Struct';
  dlgDivPasStructLocalName  = 'Class/Struct (local)';
  dlgDivPasProcedureName    = 'Procedure/Function';
  dlgDivPasBeginEndName     = 'Begin/End';
  dlgDivPasTryName          = 'Try/Except';

  dlgFoldPasBeginEnd        = 'Begin/End (nested)';
  dlgFoldPasProcBeginEnd    = 'Begin/End (procedure)';
  dlgFoldPasNestedComment   = 'Nested Comment';
  dlgFoldPasProcedure       = 'Procedure';
  dlgFoldPasUses            = 'Uses';
  dlgFoldPasVarType         = 'Var/Type (global)';
  dlgFoldLocalPasVarType    = 'Var/Type (local)';
  dlgFoldPasClass           = 'Class/Object';
  dlgFoldPasClassSection    = 'public/private';
  dlgFoldPasUnitSection     = 'Unit section';
  dlgFoldPasProgram         = 'Program';
  dlgFoldPasUnit            = 'Unit';
  dlgFoldPasRecord          = 'Record';
  dlgFoldPasTry             = 'Try';
  dlgFoldPasExcept          = 'Except/Finally';
  dlgFoldPasRepeat          = 'Repeat';
  dlgFoldPasCase            = 'Case';
  dlgFoldPasAsm             = 'Asm';
  dlgFoldPasIfDef           = '{$IfDef}';
  dlgFoldPasUserRegion      = '{%Region}';

  dlgMouseFoldExpFoldOne    = 'Fold One (All Expanded)';
  dlgMouseFoldExpFoldAll    = 'Fold All (All Expanded)';
  dlgMouseFoldColFoldOne    = 'Fold One (Some Colapsed)';
  dlgMouseFoldColFoldAll    = 'Fold All (Some Colapsed)';
  dlgMouseFoldColUnFoldOne  = 'Unfold One (Some Colapsed)';
  dlgMouseFoldColUnFoldAll  = 'Unfold All (Some Colapsed)';

  dlgMouseFoldGroup1        = 'Setting 1';
  dlgMouseFoldGroup2        = 'Setting 2';
  dlgMouseFoldEnabled       = 'Enabled';
  dlgMouseFoldButton        = 'Button';
  dlgMouseFoldButtonLeft    = 'Left';
  dlgMouseFoldButtonMiddle  = 'Middle';
  dlgMouseFoldButtonRight   = 'Right';
  dlgMouseFoldModifierShift = 'Shift';
  dlgMouseFoldModifierCtrl  = 'Ctrl';
  dlgMouseFoldModifierAlt   = 'Alt';


  // CodeTools dialog
  dlgCodeToolsOpts = 'CodeTools Options';
  dlgCodeCreation = 'Code Creation';
  dlgWordsPolicies = 'Words';
  dlgLineSplitting = 'Line Splitting';
  dlgSpaceNotCosmos{:)} = 'Space';
  dlgIdentifierCompletion = 'Identifier completion';
  dlgAdditionalSrcPath = 'Additional Source search path for all projects (.pp;.pas)';
  dlgJumpingETC = 'Jumping (e.g. Method Jumping)';
  dlgAdjustTopLine = 'Adjust top line due to comment in front';
  dlgCenterCursorLine = 'Center Cursor Line';
  dlgCursorBeyondEOL = 'Cursor beyond EOL';
  dlgSkipForwardDeclarations = 'Skip forward declarations';
  dlgClassInsertPolicy = 'Class part insert policy';
  lisClassCompletion = 'Class Completion';
  dlgAlphabetically = 'Alphabetically';
  dlgCDTLast = 'Last';
  dlgMixMethodsAndProperties = 'Mix methods and properties';
  dlgForwardProcsInsertPolicy = 'Procedure insert policy';
  dlgLast = 'Last (i.e. at end of source)';
  dlgInFrontOfMethods = 'In front of methods';
  dlgBehindMethods = 'Behind methods';
  dlgForwardProcsKeepOrder = 'Keep order of procedures';
  lisNewUnitsAreAddedToUsesSections = 'New units are added to uses sections:';
  lisFirst = 'First';
  lisInFrontOfRelated = 'In front of related';
  lisBehindRelated = 'Behind related';
  dlgMethodInsPolicy = 'Method insert policy';
  dlgCDTClassOrder = 'Class order';
  dlgKeywordPolicy = 'Keyword policy';
  dlgCDTLower = 'lowercase';
  dlgCDTUPPERCASE = 'UPPERCASE';
  dlg1UP2low = 'Lowercase, first letter up';
  dlgIdentifierPolicy = 'Identifier policy';
  dlgPropertyCompletion = 'Property completion';
  lisHeaderCommentForClass = 'Header comment for class';
  dlgCompleteProperties = 'Complete properties';
  dlgCDTReadPrefix = 'Read prefix';
  dlgCDTWritePrefix = 'Write prefix';
  dlgCDTStoredPostfix = 'Stored postfix';
  dlgCDTVariablePrefix = 'Variable prefix';
  dlgSetPropertyVariable = 'Set property Variable';
  dlgMaxLineLength = 'Max line length:';
  dlgNotSplitLineFront = 'Do not split line In front of:';
  dlgNotSplitLineAfter = 'Do not split line after:';
  dlgCDTPreview = 'Preview (Max line length = 1)';
  dlgInsSpaceFront = 'Insert space in front of';
  dlgInsSpaceAfter = 'Insert space after';
  dlgWRDPreview = 'Preview';
  dlgAddSemicolon = 'Add semicolon';
  dlgAddAssignmentOperator = 'Add assignment operator :=';

  // source editor
  locwndSrcEditor = 'Source Editor';
  
  // compiler options
  dlgCompilerOptions = 'Compiler Options';
  lisPkgEdOnlineHelpNotYetImplemented = 'Online Help not yet implemented';
  lisPkgEdRightClickOnTheItemsTreeToGetThePopupmenuWithAllAv = 'Right click '
    +'on the items tree to get the popupmenu with all available package '
    +'functions.';
  dlgSearchPaths = 'Paths';
  dlgCOParsing = 'Parsing';
  dlgCodeGeneration = 'Code';
  dlgCOLinking = 'Linking';
  dlgCOVerbosity = 'Verbosity';
  dlgCOCfgCmpMessages = 'Messages';
  dlgCOOther = 'Other';
  dlgCOInherited = 'Inherited';
  dlgCOCompilation = 'Compilation';
  lisBrowseForCompiler = 'Browse for Compiler (%s)';
  lisUnitOutputDirectory = 'Unit Output directory';
  lisSelectANode = 'Select a node';
  dlgShowCompilerOptions = 'Show compiler options';
  dlgCOOpts = 'Options: ';
  dlgCOAsmStyle = 'Assembler style:';
  lisNoCompilerOptionsInherited = 'No compiler options inherited.';
  lisunitPath = 'unit path';
  lisincludePath = 'include path';
  lisobjectPath = 'object path';
  lislibraryPath = 'library path';
  lislinkerOptions = 'linker options';
  liscustomOptions = 'custom options';
  dlgCOAsIs = 'As-Is';
  dlgSyntaxOptions = 'Syntax options';
  dlgAssemblerDefault = 'Default';
  dlgDelphi2Ext = 'Delphi 2 Extensions';
  dlgCOCOps = 'C Style Operators (*=, +=, /= and -=)';
  dlgAssertCode = 'Include Assertion Code';
  dlgLabelGoto = 'Allow LABEL and GOTO';
  dlgCppInline = 'C++ Styled INLINE';
  dlgCMacro = 'C Style Macros (global)';
  dlgBP7Cptb = 'TP/BP 7.0 Compatible';
  dlgInitDoneOnly = 'Constructor name must be ''' + 'init' + ''' (destructor must be ''' + 'done' + ''')';
  dlgStaticKeyword = 'Static Keyword in Objects';
  dlgDeplhiComp = 'Delphi Compatible';
  dlgCOAnsiStr = 'Use Ansi Strings';
  dlgGPCComp = 'GPC (GNU Pascal Compiler) Compatible';
  dlgCOUnitStyle = 'Unit Style:';
  dlgCOSmartLinkable = 'Smart Linkable';
  dlgCOChecks = 'Checks:';
  dlgCORange = 'Range';
  dlgCOOverflow = 'Overflow';
  dlgCOStack = 'Stack';
  dlgHeapSize = 'Heap Size';
  dlgCOGenerate = 'Generate:';
  dlgCONormal = 'Normal Code';
  dlgCOFast = 'Faster Code';
  dlgCOSmaller = 'Smaller Code';
  dlgTargetProc = 'Target processor';
  dlgTargetPlatform = 'Target Platform:';
  dlgOptimiz = 'Optimizations:';
  dlgCOKeepVarsReg = 'Keep certain variables in registers';
  dlgUncertOpt = 'Uncertain Optimizations';
  dlgLevelNoneOpt = 'Level 0 (no extra Optimizations)';
  dlgLevel1Opt = 'Level 1 (quick and debugger friendly)';
  dlgLevel2Opt = 'Level 2 (Level 1 + quick optimizations)';
  dlgLevel3Opt = 'Level 3 (Level 2 + slow optimizations)';
  dlgTargetOS = 'Target OS';
  dlgTargetCPUFamily = 'Target CPU family';
  dlgCODebugging = 'Debugging:';
  dlgCOGDB = 'Generate Debugging Info For GDB (Slows Compiling)';
  dlgCODBX = 'Generate Debugging Info For DBX (Slows Compiling)';
  dlgLNumsBct = 'Display Line Numbers in Run-time Error Backtraces';
  dlgGenerateDwarf = 'Generate dwarf debug information';
  dlgCOHeaptrc = 'Use Heaptrc Unit';
  dlgCOValgrind = 'Generate code for valgrind';
  dlgGPROF = 'Generate code for gprof';
  dlgCOStrip = 'Strip Symbols From Executable';
  dlgExtSymb = 'Use external gdb debug symbols file';
  dlgLinkLibraries = 'Link Style:';
  dlgLinkSmart = 'Link Smart';
  dlgPassOptsLinker = 'Pass Options To The Linker (Delimiter is space)';
  lisCOTargetOSSpecificOptions = 'Target OS specific options';
  dlgWin32GUIApp = 'Win32 gui application';
  dlgVerbosity = 'Verbosity during compilation:';
  dlgCOShowErr = 'Show Errors';
  dlgShowWarnings = 'Show Warnings';
  dlgShowNotes = 'Show Notes';
  dlgShowHint = 'Show Hints';
  dlgShowGeneralInfo = 'Show general info';
  dlgShowProcsError = 'Show all procs on error';
  dlgShowEverything ='Show everything';
  dlgShowSummary ='Show summary';
  dlgShowDebugInfo = 'Show debug info';
  dlgShowUsedFiles = 'Show used files';
  dlgShowTriedFiles = 'Show tried files';
  dlgShowDefinedMacros = 'Show defined macros';
  dlgShowCompiledProcedures = 'Show compiled procedures';
  dlgShowConditionals = 'Show conditionals';
  dlgShowExecutableInfo = 'Show executable info (Win32 only)';
  dlgShowNothing = 'Show nothing (only errors)';
  dlgWriteFPCLogo = 'Write an FPC logo';
  dlgHintsUnused = 'Show Hints for unused units in main source';
  dlgHintsParameterSenderNotUsed = 'Show Hints for parameter "Sender" not used';
  dlgConfigFiles = 'Config Files:';
  dlgUseFpcCfg = 'Use standard Compiler Config File (fpc.cfg)';
  dlgUseCustomConfig = 'Use additional Compiler Config File';
  lisCustomOptions2 = 'Custom options';
  dlgCOConditionals = 'Conditionals';
  dlgStopAfterNrErr = 'Stop after number of errors:';
  dlgOtherUnitFiles = 'Other Unit Files (-Fu) (Delimiter is semicolon):';
  dlgCOIncFiles = 'Include Files (-Fi):';
  dlgCOSources = 'Other Sources (.pp/.pas files, used only by IDE not by compiler)';
  dlgCOLibraries = 'Libraries (-Fl):';
  dlgCODebugPath = 'Debugger path addition (none):';
  lisCompiler = 'Compiler';
  lisToFPCPath = 'Path:';
  lisCOSkipCallingCompiler = 'Skip calling Compiler';
  lisCOAmbiguousAdditionalCompilerConfigFile = 'Ambiguous additional compiler '
    +'config file';
  lisCOWarningTheAdditionalCompilerConfigFileHasTheSameNa = 'Warning: The '
    +'additional compiler config file has the same name, as one of the '
    +'standard config filenames the FreePascal compiler is looking for. This '
    +'can result in ONLY parsing the additional config and skipping the '
    +'standard config.';
  lisCOClickOKIfAreSureToDoThat = '%s%sClick OK if you are sure to do that.';
  lisCOCallOn = 'Call on:';
  lisCOCallOnCompile = 'Compile';
  lisCOCallOnBuild = 'Build';
  lisCOCallOnRun = 'Run';
  dlgCOCreateMakefile = 'Create Makefile';
  lisCOExecuteAfter = 'Execute after';
  lisCOExecuteBefore = 'Execute before';
  lisAdditionalCompilerOptionsInheritedFromPackages = 'Additional compiler '
    +'options inherited from packages';
  lisCOCommand = 'Command:';
  lisCOScanForFPCMessages = 'Scan for FPC messages';
  lisCOScanForMakeMessages = 'Scan for Make messages';
  lisCOShowAllMessages = 'Show all messages';
  dlgUnitOutp = 'Unit output directory (-FU):';
  lisCOdefault = 'default (%s)';
  dlgButApply = 'Apply';
  dlgCOShowOptions = '&Show Options';
  dlgCOLoadSave = 'Load/Save';
  dlgMainViewForms = 'View project forms';
  dlgMainViewUnits = 'View project units';
  dlgMainViewFrames = 'View project frames';
  dlgMultiSelect = 'Multi Select';
  
  // check compiler options dialog
  dlgCCOCaption = 'Checking compiler options';
  dlgCCOTest = 'Test';
  dlgCCOResults = 'Results';
  lisCCOCopyOutputToCliboard = 'Copy output to clipboard';
  lisCCOContains = 'contains ';
  lisCCOSpaces = 'spaces';
  lisCCOSpecialCharacters = 'special characters';
  lisCCONonASCII = 'non ASCII';
  lisCCOWrongPathDelimiter = 'wrong path delimiter';
  lisCCOUnusualChars = 'unusual characters';
  lisCCOHasNewLine = 'new line symbols';
  lisCCOInvalidSearchPath = 'Invalid search path';
  lisCCOSkip = 'Skip';
  dlgCCOTestCheckingCompiler = 'Test: Checking compiler ...';
  lisDoesNotExists = '%s does not exists: %s';
  lisCCOInvalidCompiler = 'Invalid compiler';
  lisCCOCompilerNotAnExe = 'The compiler "%s" is not an executable file.%s'
    +'Details: %s';
  lisCCOAmbiguousCompiler = 'Ambiguous compiler';
  lisCCOSeveralCompilers = 'There are several FreePascal Compilers in your path.%s%s%s'
    +'Maybe you forgot to delete an old compiler?';
  dlgCCOTestCheckingFPCConfigs = 'Test: Checking fpc configs ...';
  lisCCONoCfgFound = 'no fpc.cfg found';
  lisCCOMultipleCfgFound = 'multiple compiler configs found: ';
  dlgCCOTestCompilingEmptyFile = 'Test: Compiling an empty file ...';
  lisCCOInvalidTestDir = 'Invalid Test Directory';
  lisCCOCheckTestDir = 'Please check the Test directory under %s'
    +'Environment -> Environment Options -> Files -> Directory for building test projects';
  lisCCOUnableToCreateTestFile = 'Unable to create Test File';
  lisCCOUnableToCreateTestPascalFile = 'Unable to create Test pascal file "%s".';
  dlgCCOTestToolCompilingEmptyFile = 'Test: Compiling an empty file';
  lisCCORelUnitPathFoundInCfg = 'relative unit path found in fpc cfg: %s';
  dlgCCOTestCheckingCompilerConfig = 'Test: Checking compiler configuration ...';
  lisCCOEnglishMessageFileMissing = 'english message file for fpc is missing:'
    +'components/codetools/fpc.errore.msg';
  lisCCOMsgPPUNotFound = 'compiled FPC unit not found: %s.ppu';
  lisCCOMissingUnit = 'Missing unit';
  lisCCOPPUNotFoundDetailed = 'The compiled FPC unit %s.ppu was not found.%s'
    +'This typically means your fpc.cfg has a bug. Or your FPC installation is broken.';
  dlgCCOTestMissingPPU = 'Test: Checking missing fpc ppu ...';
  dlgCCOTestCompilerDate = 'Test: Checking compiler date ...';
  lisCCOErrorCaption = 'Error';
  lisEMDEmtpyMethods = 'Emtpy Methods';
  lisEMDSearchInTheseClassSections = 'Search in these class sections:';
  lisUnableToLoadPackage = 'Unable to load package %s%s%s';
  lisSAMThisMethodCanNotBeOverriddenBecauseItIsDefinedInTh = 'This method can '
    +'not be overridden because it is defined in the current class';
  lisSAMIsAnAbstractClassItHasAbstractMethods = '%s is an abstract class, it '
    +'has %s abstract methods.';
  lisSAMAbstractMethodsOf = 'Abstract methods of %s';
  lisSAMThereAreAbstractMethodsToOverrideSelectTheMethodsF = 'There are %s '
    +'abstract methods to override.%sSelect the methods for which stubs '
    +'should be created:';
  lisSAMNoAbstractMethodsFound = 'No abstract methods found';
  lisSAMCursorIsNotInAClassDeclaration = 'Cursor is not in a class declaration';
  lisSAMIDEIsBusy = 'IDE is busy';
  lisSAMThereAreNoAbstractMethodsLeftToOverride = 'There are no abstract '
    +'methods left to override.';
  lisSAMUnableToShowAbstractMethodsOfTheCurrentClassBecaus = 'Unable to show '
    +'abstract methods of the current class, because';
  lisCCOUnableToGetFileDate = 'Unable to get file date of %s.';
  lisCCOWarningCaption = 'Warning';
  lisCCODatesDiffer = 'The dates of the .ppu files of FPC'
    +' differ more than one hour.%s'
    +'This can mean, they are from two different installations.%s'
    +'File1: %s%s'
    +'File2: %s';
  lisCCOPPUOlderThanCompiler = 'There is a .ppu file older than the compiler itself:%s%s';
  lisCCOPPUExistsTwice = 'ppu exists twice: %s, %s';
  dlgCCOTestSrcInPPUPaths = 'Test: Checking sources in fpc ppu search paths ...';
  lisCCOFPCUnitPathHasSource = 'FPC unit path contains a source: ';
  lisTheOutputDirectoryOfIsListedInTheUnitSearchPathOf = 'The output '
    +'directory of %s is listed in the unit search path of %s.';
  lisTheOutputDirectoryShouldBeASeparateDirectoryAndNot = ' The output '
    +'directory should be a separate directory and not contain any source '
    +'files.';
  lisTheOutputDirectoryOfIsListedInTheIncludeSearchPath = 'The output '
    +'directory of %s is listed in the include search path of %s.';
  lisTheOutputDirectoryOfIsListedInTheInheritedUnitSear = 'The output '
    +'directory of %s is listed in the inherited unit search path of %s.';
  lisTheOutputDirectoryOfIsListedInTheInheritedIncludeS = 'The output '
    +'directory of %s is listed in the inherited include search path of %s.';
  lisCCOTestsSuccess = 'All tests succeeded.';
  lisCCOWarningMsg = 'WARNING: ';
  lisCCOHintMsg = 'HINT: ';
  lisCCOErrorMsg = 'ERROR: ';
  
  // show compiler options dialog
  dlgCommandLineParameters = 'Command line parameters';

  // custom messages
  dlgBrowseMsgFilter = 'Free Pascal Compiler messages file (*.msg)|*.msg|Any Files (*.*)|*.*';
  dlgCompilerMessage = 'Compiler Messages';
  dlgUseMsgFile = 'Use messages file';

  // project options dialog
  dlgProjectOptions = 'Project Options';
  dlgPOApplication = 'Application';
  lisApplicationAGraphicalLclFreepascalProgramTheProgra = 'Application%sA '
    +'graphical lcl/freepascal program. The program file is automatically '
    +'maintained by lazarus.';
  dlgPOFroms = 'Forms';
  dlgPOMisc = 'Miscellaneous';
  dlgPOI18n = 'i18n';
  rsEnableI18n = 'Enable i18n';
  rsI18nOptions = 'i18n Options';
  rsPOOutputDirectory = 'PO Output Directory:';
  rsIncludeVersionInfoInExecutable = 'Include Version Info in executable';
  rsVersionNumbering = 'Version numbering';
  rsVersion = 'Version:';
  rsMajorRevision = 'Major revision:';
  rsMinorRevision = 'Minor revision:';
  rsBuild = 'Build:';
  rsAutomaticallyIncreaseBuildNumber = 'Automatically increase build number';
  rsLanguageOptions = 'Language options';
  rsLanguageSelection = 'Language selection:';
  rsCharacterSet = 'Character set:';
  rsOtherInfo = 'Other info';
  rsCopyright = 'Copyright:';
  rsAdditionalInfo = 'Additional info';
  dlgPOSaveSession = 'Session';
  dlgApplicationSettings = 'Application Settings';
  dlgPOTitle = 'Title:';
  dlgPOOutputSettings = 'Output Settings';
  dlgPOTargetFileName = 'Target file name:';
  dlgPOUseAppBundle = 'Use Application Bundle for running and debugging (darwin only)';
  dlgPOCreateAppBundle = 'Create Application Bundle';
  dlgPOUseManifest = 'Use manifest file to enable themes (windows only)';
  dlgPOIcon = 'Icon:';
  dlgPOLoadIcon = 'Load Icon';
  dlgPOSaveIcon = 'Save Icon';
  dlgPOClearIcon = 'Clear Icon';
  dlgPOIconDesc = '(size: %d:%d, bpp: %d)';
  dlgPOIconDescNone = '(none)';

  dlgAutoCreateForms = 'Auto-create forms:';
  dlgAvailableForms = 'Available forms:';
  dlgAutoCreateNewForms = 'When creating new forms, add them to auto-created forms';
  dlgSaveEditorInfo = 'Save editor info for closed files';
  dlgSaveEditorInfoProject = 'Save editor info only for project files';
  lisMainUnitIsPascalSource = 'Main Unit is Pascal Source';
  lisMainUnitHasUsesSectionContainingAllUnitsOfProject = 'Main Unit has Uses '
    +'Section containing all Units of project';
  lisMainUnitHasApplicationCreateFormStatements = 'Main Unit has Application.'
    +'CreateForm statements';
  lisMainUnitHasApplicationTitleStatements = 'Main Unit has Application.Title '
    +'statements';
  lisProjectIsRunnable = 'Project is runnable';
  lisProjOptsAlwaysBuildEvenIfNothingChanged = 'Always build (even if nothing '
    +'changed)';
  dlgRunParameters = 'Run parameters';
  dlgRunOLocal = 'Local';
  dlgRunOEnvironment = 'Environment';
  dlgHostApplication = 'Host application';
  dlgCommandLineParams = 'Command line parameters (without application name)';
  dlgUseLaunchingApp = 'Use launching application';
  lisUseLaunchingApplicationGroupBox = 'Launching application';
  dlgROWorkingDirectory = 'Working directory';
  dlgRunODisplay = 'Display (not for win32, e.g. 198.112.45.11:0, x.org:1, hydra:0.1)';
  dlgRunOUsedisplay = 'Use display';
  dlgRunOSystemVariables = 'System variables';
  dlgRunOVariable = 'Variable';
  dlgRunOValue = 'Value';
  dlgRunOUserOverrides = 'User overrides';
  dlgIncludeSystemVariables = 'Include system variables';
  dlgDirectoryDoesNotExist = 'Directory does not exist';
  lisRunParamsFileNotExecutable = 'File not executable';
  lisRunParamsTheHostApplicationIsNotExecutable = 'The host application %s%s%'
    +'s is not executable.';
  dlgTheDirectory = 'The directory "';
  dlgDoesNotExist = '" does not exist.';
  dlgTextToFing = '&Text to Find';
  dlgReplaceWith = '&Replace With';
  dlgFROpts = 'Options';
  lisBFWhenThisFileIsActiveInSourceEditor = 'When this file is active in '
    +'source editor ...';
  lisBFOnBuildProjectExecuteTheBuildFileCommandInstead = 'On build project '
    +'execute the Build File command instead';
  lisBFOnRunProjectExecuteTheRunFileCommandInstead = 'On run project execute '
    +'the Run File command instead';
  lisCEFilter = '(Filter)';
  dlgCaseSensitive = '&Case Sensitive';
  lisDistinguishBigAndSmallLettersEGAAndA = 'Distinguish big and small '
    +'letters e.g. A and a';
  dlgWholeWordsOnly = '&Whole Words Only';
  lisOnlySearchForWholeWords = 'Only search for whole words';
  dlgRegularExpressions = '&Regular Expressions';
  lisActivateRegularExpressionSyntaxForTextAndReplaceme = 'Activate regular '
    +'expression syntax for text and replacement (pretty much like perl)';
  lisAllowSearchingForMultipleLines = 'Allow searching for multiple lines';
  dlgPromptOnReplace = '&Prompt On Replace';
  lisAskBeforeReplacingEachFoundText = 'Ask before replacing each found text';
  dlgSROrigin = 'Origin';
  dlgPLDPackageGroup = 'Package group';
  lisPLDExists = 'Exists';
  dlgFromCursor = '&From Cursor';
  dlgEntireScope = '&Entire Scope';
  dlgScope = 'Scope';
  lisWithRequiredPackages = 'With required packages';
  lisLevels = 'Levels';
  lisShowPackages = 'Show packages';
  lisShowUnits = 'Show units';
  lisShowIdentifiers = 'Show identifiers';
  lisFilter = 'Filter';
  lisRegularExpression = 'Regular expression';
  lisUpdatePreview = 'Update preview';
  lisInvalidFilter = 'Invalid filter';
  lisInvalidExpression = 'Invalid expression:%s%s%s%s';
  lisExcludeFilter2 = 'Exclude filter';
  lisPrivate = 'Private';
  lisProtected = 'Protected';
  lisEMDPublic = 'Public';
  lisEMDPublished = 'Published';
  lisEMDAll = 'All';
  lisEMDOnlyPublished = 'Only published';
  lisEMDFoundEmptyMethods = 'Found empty methods:';
  lisEMDRemoveMethods = 'Remove methods';
  lisExpandAllPackages = 'Expand all packages';
  lisCollapseAllPackages = 'Collapse all packages';
  lisExpandAllUnits = 'Expand all units';
  lisCollapseAllUnits = 'Collapse all units';
  lisExpandAllClasses = 'Expand all classes';
  lisCollapseAllClasses = 'Collapse all classes';
  lisExport = 'Export ...';
  lisBegins = 'begins';
  lisIdentifierBeginsWith = 'Identifier begins with ...';
  lisUnitNameBeginsWith = 'Unit name begins with ...';
  lisPackageNameBeginsWith = 'Package name begins with ...';
  lisContains = 'contains';
  lisIdentifierContains = 'Identifier contains ...';
  lisUnitNameContains = 'Unit name contains ...';
  lisPackageNameContains = 'Package name contains ...';
  lisFRIinCurrentUnit = 'in current unit';
  lisFRIinMainProject = 'in main project';
  lisFRIinProjectPackageOwningCurrentUnit = 'in project/package owning '
    +'current unit';
  lisFRIinAllOpenPackagesAndProjects = 'in all open packages and projects';
  lisFRIRenameAllReferences = 'Rename all References';
  dlgGlobal = '&Global';
  lisPLDUser = 'User';
  dlgSelectedText = '&Selected Text';
  dlgDirection = 'Direction';
  lisFRForwardSearch = 'Forwar&d search';
  lisFRBackwardSearch = '&Backward search';
  dlgUpWord = 'Up';
  lisRight = 'Right';
  dlgDownWord = 'Down';
  dlgReplaceAll = 'Replace &All';
  
  // IDEOptionDefs
  dlgGetPosition = 'Get position';
  dlgLeftPos     = 'Left:';
  dlgWidthPos    = 'Width:';
  dlgTopPos      = 'Top:';
  DlgHeightPos   = 'Height:';
  rsiwpUseWindowManagerSetting = 'Use windowmanager setting';
  rsiwpDefault                 = 'Default';
  rsiwpRestoreWindowGeometry   = 'Restore window geometry';
  rsiwpDocked                  = 'Docked';
  rsiwpCustomPosition          = 'Custom position';
  rsiwpRestoreWindowSize       = 'Restore window size';

  // Code Explorer
  lisCodeExplorer = 'Code Explorer';

  // Unit editor
  uemFindDeclaration = '&Find Declaration';
  uemOpenFileAtCursor = '&Open file at cursor';
  uemProcedureJump = 'Procedure Jump';
  uemClosePage = '&Close Page';
  uemCloseOtherPages = 'Close All &Other Pages';
  uemCut = 'Cut';
  uemCopy = 'Copy';
  uemPaste = 'Paste';
  uemCopyFilename = 'Copy Filename';
  uemGotoBookmark = '&Goto Bookmark';
  uemSetFreeBookmark = 'Set a free Bookmark';
  uemNextBookmark = 'Goto next Bookmark';
  uemPrevBookmark = 'Goto previous Bookmark';
  uemBookmarkN = 'Bookmark';
  lisChangeEncoding = 'Change Encoding';
  lisEncodingOfFileOnDiskIsNewEncodingIs2 = 'Encoding of file %s%s%s%son disk '
    +'is %s. New encoding is %s.';
  lisChangeFile = 'Change file';
  lisEncodingOfFileOnDiskIsNewEncodingIs = 'Encoding of file %s%s%s%son disk '
    +'is %s. New encoding is %s.';
  lisReopenWithAnotherEncoding = 'Reopen with another encoding';
  lisAbandonChanges = 'Abandon changes?';
  lisAllYourModificationsToWillBeLostAndTheFileReopened = 'All your modificatio'
    +'ns to %s%s%s%swill be lost and the file reopened.';
  lisOpenLfm = 'Open %s';
  lisUtf8WithBOM = 'UTF-8 with BOM';
  uemSetBookmark = '&Set Bookmark';
  uemToggleBookmark = '&Toggle Bookmark';
  uemReadOnly = 'Read Only';
  uemShowLineNumbers = 'Show Line Numbers';
  uemShowUnitInfo = 'Unit Info';
  uemDebugWord = 'Debug';
  uemToggleBreakpoint = '&Toggle Breakpoint';
  uemAddWatchAtCursor = 'Add &Watch At Cursor';
  uemRunToCursor='&Run to Cursor';
  uemViewCallStack = 'View Call Stack';
  uemMovePageLeft='Move page left';
  uemMovePageRight='Move page right';
  uemMovePageLeftmost='Move page leftmost';
  uemMovePageRightmost='Move page rightmost';
  uemRefactor = 'Refactoring';
  uemCompleteCode = 'Complete Code';
  uemEncloseSelection = 'Enclose Selection';
  uemExtractProc = 'Extract Procedure';
  uemInvertAssignment = 'Invert Assignment';
  uemFindIdentifierReferences = 'Find Identifier References';
  uemRenameIdentifier = 'Rename Identifier';
  uemEditorproperties='Editor properties';
  ueNotImplCap='Not implemented yet';
  ueNotImplText='If You can help us to implement this feature, mail to '
   +'lazarus@miraclec.com';
  ueNotImplCapAgain='I told You: Not implemented yet';
  ueFileROCap= 'File is readonly';
  ueFileROText1='The file "';
  ueFileROText2='" is not writable.';
  ueModified='Modified';
  uepReadonly= 'Readonly';
  uepIns='INS';
  uepOvr='OVR';
  lisUEFontWith = 'Font without UTF-8';
  lisUETheCurre = 'The current editor font does not support UTF-8, but your '
    +'system seems to use it.%sThat means non ASCII characters will probably '
    +'be shown incorrect.%sYou can select another font in the editor options.';
  lisUEDoNotSho = 'Do not show this message again.';
  uemInsertTodo = 'Insert Todo';
  lisCodeHelpShowEmptyMethods = 'Show empty methods';
  lisCodeHelpShowUnusedUnits = 'Show unused units';
  uemHighlighter = 'Highlighter';
  uemEncoding = 'Encoding';

  // Form designer
  lisInvalidMultiselection = 'Invalid multiselection';
  lisUnableConvertBinaryStreamToText = 'Unable convert binary stream to text';
  lisUnableToStreamSelectedComponents = 'Unable to stream selected components';
  lisCanNotCopyTopLevelComponent = 'Can not copy top level component.';
  lisCopyingAWholeFormIsNotImplemented = 'Copying a whole form is not '
    +'implemented.';
  lisThereWasAnErrorDuringWritingTheSelectedComponent = 'There was an error '
    +'during writing the selected component %s:%s:%s%s';
  lisThereWasAnErrorWhileConvertingTheBinaryStreamOfThe = 'There was an error '
    +'while converting the binary stream of the selected component %s:%s:%s%s';
  lisUnableCopyComponentsToClipboard = 'Unable copy components to clipboard';
  lisThereWasAnErrorWhileCopyingTheComponentStreamToCli = 'There was an error '
    +'while copying the component stream to clipboard:%s%s';
  lisErrorIn = 'Error in %s';
  lisDesThereIsAlreadyAnotherComponentWithTheName = 'There is already another '
    +'component with the name %s%s%s.';
  lisTheComponentEditorOfClassInvokedWithVerbHasCreated = 'The component '
    +'editor of class %s%s%s%sinvoked with verb #%s %s%s%s%shas created the '
    +'error:%s%s%s%s';
  lisTheComponentEditorOfClassHasCreatedTheError = 'The component editor of '
    +'class %s%s%s has created the error:%s%s%s%s';
  fdInvalidMultiselectionText='Multiselected components must be of a single form.';
  lisInvalidDelete = 'Invalid delete';
  lisTheComponentIsInheritedFromToDeleteAnInheritedComp = 'The component %s '
    +'is inherited from %s.%sTo delete an inherited component open the '
    +'ancestor and delete it there.';
  lisTheRootComponentCanNotBeDeleted = 'The root component can not be deleted.';
  fdmAlignWord='Align';
  fdmMirrorHorizontal='Mirror Horizontal';
  fdmMirrorVertical='Mirror Vertical';
  fdmScaleWord='Scale';
  fdmSizeWord='Size';
  fdmTabOrder='Tab Order...';
  fdmZOrder='Z-order';
  fdmOrder='Order';
  fdmOrderMoveTofront='Move to Front';
  fdmOrderMoveToback='Move to Back';
  fdmOrderForwardOne='Forward One';
  fdmOrderBackOne='Back One';
  fdmDeleteSelection='Delete Selection';
  fdmSelectAll='Select All';
  lisChangeClass = 'Change Class';
  fdmSnapToGridOption='Option: Snap to grid';
  fdmSnapToGuideLinesOption='Option: Snap to guide lines';
  lisViewSourceLfm = 'View Source (.lfm)';
  fdmSaveFormAsXML = 'Save form as XML';

  //-----------------------
  // keyMapping
  //
  srkmEditKeys ='Edit Keys';
  srkmCommand  = 'Command:';
  lisKeyOr2KeySequence = 'Key (or 2 key sequence)';
  lisTheKeyIsAlreadyAssignedToRemoveTheOldAssignmentAnd = 'The key %s%sis '
    +'already assigned to %s.%s%sRemove the old assignment and assign the key '
    +'to the new function%s%s?';
  lisAlternativeKeyOr2KeySequence = 'Alternative key (or 2 key sequence)';
  srkmConflic  = 'Conflict ';
  srkmConflicW = ' conflicts with ';
  srkmCommand1 = '    command1 "';
  srkmCommand2 = '    command2 "';
  srkmEditForCmd='Edit keys of command';
  lisChooseAKey = 'Choose a key ...';
  srkmKey      = 'Key (or 2 keys combination)';
  srkmGrabKey  = 'Grab key';
  srkmGrabSecondKey  = 'Grab second key';
  srkmPressKey = 'Please press a key ...';
  srkmAlternKey= 'Alternative key (or 2 keys combination)';
  srkmAlreadyConnected = ' The key "%s" is already connected to "%s".';

  //Commands
  srkmecWordLeft              = 'Move cursor word left';
  srkmecWordRight             = 'Move cursor word right';
  srkmecLineStart             = 'Move cursor to line start';
  srkmecLineEnd               = 'Move cursor to line end';
  srkmecPageUp                = 'Move cursor up one page';
  srkmecPageDown              = 'Move cursor down one page';
  srkmecPageLeft              = 'Move cursor left one page';
  srkmecPageRight             = 'Move cursor right one page';
  srkmecPageTop               = 'Move cursor to top of page';
  srkmecPageBottom            = 'Move cursor to bottom of page';
  srkmecEditorTop             = 'Move cursor to absolute beginning';
  srkmecEditorBottom          = 'Move cursor to absolute end';
  srkmecGotoXY                = 'Goto XY';
  srkmecSelLeft               = 'SelLeft';
  srkmecSelRight              = 'SelRight';
  srkmecSelUp                 = 'Select Up';
  srkmecSelDown               = 'Select Down';
  srkmecSelWordLeft           = 'Select Word Left';
  srkmecSelWordRight          = 'Select Word Right';
  srkmecSelLineStart          = 'Select Line Start';
  srkmecSelLineEnd            = 'Select Line End';
  srkmecSelPageUp             = 'Select Page Up';
  srkmecSelPageDown           = 'Select Page Down';
  srkmecSelPageLeft           = 'Select Page Left';
  srkmecSelPageRight          = 'Select Page Right';
  srkmecSelPageTop            = 'Select Page Top';
  srkmecSelPageBottom         = 'Select Page Bottom';
  srkmecSelEditorTop          = 'Select to absolute beginning';
  srkmecSelEditorBottom       = 'Select to absolute end';
  srkmecColSelUp              = 'Column Select Up';
  srkmecColSelDown            = 'Column Select Down';
  srkmecColSelLeft            = 'Column Select Left';
  srkmecColSelRight           = 'Column Select Right';
  srkmecColSelWordLeft        = 'Column Select Word Left';
  srkmecColSelWordRight       = 'Column Select Word Right';
  srkmecColSelPageDown        = 'Column Select Page Down';
  srkmecColSelPageBottom      = 'Column Select Page Bottom';
  srkmecColSelPageUp          = 'Column Select Page Up';
  srkmecColSelPageTop         = 'Column Select Page Top';
  srkmecColSelLineStart       = 'Column Select Line Start';
  srkmecColSelLineEnd         = 'Column Select Line End';
  srkmecColSelEditorTop       = 'Column Select to absolute beginning';
  srkmecColSelEditorBottom    = 'Column Select to absolute end';
  srkmecSelGotoXY             = 'Select Goto XY';
  srkmecSelectAll             = 'Select All';
  srkmecDeleteLastChar        = 'Delete Last Char';
  srkmecDeletechar            = 'Delete char at cursor';
  srkmecDeleteWord            = 'Delete to end of word';
  srkmecDeleteLastWord        = 'Delete to start of word';
  srkmecDeleteBOL             = 'Delete to beginning of line';
  srkmecDeleteEOL             = 'Delete to end of line';
  srkmecDeleteLine            = 'Delete current line';
  srkmecClearAll              = 'Delete whole text';
  srkmecLineBreak             = 'Break line and move cursor';
  srkmecInsertLine            = 'Break line, leave cursor';
  srkmecChar                  = 'Char';
  srkmecImeStr                = 'Ime Str';
  srkmecCut                   = 'Cut selection to clipboard';
  srkmecCopy                  = 'Copy selection to clipboard';
  srkmecPaste                 = 'Paste clipboard to current position';
  srkmecScrollUp              = 'Scroll up one line';
  srkmecScrollDown            = 'Scroll down one line';
  srkmecScrollLeft            = 'Scroll left one char';
  srkmecScrollRight           = 'Scroll right one char';
  srkmecInsertMode            = 'Insert Mode';
  srkmecOverwriteMode         = 'Overwrite Mode';
  srkmecToggleMode            = 'Toggle Mode';
  srkmecBlockIndent           = 'Indent block';
  srkmecBlockUnindent         = 'Unindent block';
  srkmecShiftTab              = 'Shift Tab';
  lisTab = 'Tab';
  srkmecMatchBracket          = 'Go to matching bracket';
  srkmecNormalSelect          = 'Normal selection mode';
  srkmecColumnSelect          = 'Column selection mode';
  srkmecLineSelect            = 'Line selection mode';
  srkmecAutoCompletion        = 'Code template completion';
  srkmecUserFirst             = 'User First';
  srkmecSetFreeBookmark       = 'Set a free Bookmark';
  srkmecPrevBookmark          = 'Previous Bookmark';
  srkmecNextBookmark          = 'Next Bookmark';
  lisKMGoToMarker0 = 'Go to marker 0';
  lisKMGoToMarker1 = 'Go to marker 1';
  lisKMGoToMarker2 = 'Go to marker 2';
  lisKMGoToMarker3 = 'Go to marker 3';
  lisKMGoToMarker4 = 'Go to marker 4';
  lisKMGoToMarker5 = 'Go to marker 5';
  lisKMGoToMarker6 = 'Go to marker 6';
  lisKMGoToMarker7 = 'Go to marker 7';
  lisKMGoToMarker8 = 'Go to marker 8';
  lisKMGoToMarker9 = 'Go to marker 9';
  lisKMSetMarker0 = 'Set marker 0';
  lisKMSetMarker1 = 'Set marker 1';
  lisKMSetMarker2 = 'Set marker 2';
  lisKMSetMarker3 = 'Set marker 3';
  lisKMSetMarker4 = 'Set marker 4';
  lisKMSetMarker5 = 'Set marker 5';
  lisKMSetMarker6 = 'Set marker 6';
  lisKMSetMarker7 = 'Set marker 7';
  lisKMSetMarker8 = 'Set marker 8';
  lisKMSetMarker9 = 'Set marker 9';
  lisKMToggleMarker0 = 'Toggle marker 0';
  lisKMToggleMarker1 = 'Toggle marker 1';
  lisKMToggleMarker2 = 'Toggle marker 2';
  lisKMToggleMarker3 = 'Toggle marker 3';
  lisKMToggleMarker4 = 'Toggle marker 4';
  lisKMToggleMarker5 = 'Toggle marker 5';
  lisKMToggleMarker6 = 'Toggle marker 6';
  lisKMToggleMarker7 = 'Toggle marker 7';
  lisKMToggleMarker8 = 'Toggle marker 8';
  lisKMToggleMarker9 = 'Toggle marker 9';
  srkmecGotoMarker            = 'Go to Marker %d';
  srkmecSetMarker             = 'Set Marker %d';
  srkmecToggleMarker          = 'Toggle Marker %d';

  // sourcenotebook
  lisKMToggleBetweenUnitAndForm = 'Toggle between Unit and Form';
  srkmecNextEditor            = 'Go to next editor';
  srkmecPrevEditor            = 'Go to prior editor';
  srkmecMoveEditorLeft        = 'Move editor left';
  srkmecMoveEditorRight       = 'Move editor right';
  srkmecMoveEditorLeftmost    = 'Move editor leftmost';
  srkmecMoveEditorRightmost   = 'Move editor rightmost';
  lisKMGoToSourceEditor1 = 'Go to source editor 1';
  lisKMGoToSourceEditor2 = 'Go to source editor 2';
  lisKMGoToSourceEditor3 = 'Go to source editor 3';
  lisKMGoToSourceEditor4 = 'Go to source editor 4';
  lisKMGoToSourceEditor5 = 'Go to source editor 5';
  lisKMGoToSourceEditor6 = 'Go to source editor 6';
  lisKMGoToSourceEditor7 = 'Go to source editor 7';
  lisKMGoToSourceEditor8 = 'Go to source editor 8';
  lisKMGoToSourceEditor9 = 'Go to source editor 9';
  srkmecGotoEditor            = 'Go to editor %d';
  srkmEcFoldLevel             = 'Fold to Level %d';
  srkmecUnFoldAll             = 'Unfold all';
  srkmecFoldCurrent           = 'Fold at Cursor';
  srkmecUnFoldCurrent         = 'Unfold at Cursor';
  srkmecToggleMarkupWord      = 'Toggle Current-Word highlight';

  // edit menu
  srkmecSelectionTabs2Spaces     = 'Convert tabs to spaces in selection';
  lisKMEncloseSelection = 'Enclose selection';
  srkmecInsertCharacter          = 'Insert from Charactermap';
  srkmecInsertGPLNotice          = 'Insert GPL notice';
  srkmecInsertLGPLNotice         = 'Insert LGPL notice';
  srkmecInsertModifiedLGPLNotice = 'Insert modified LGPL notice';
  lisKMInsertUsername = 'Insert username';
  lisKMInsertDateAndTime = 'Insert date and time';
  srkmecInsertUserName           = 'Insert current username';
  srkmecInsertDateTime           = 'Insert current date and time';
  srkmecInsertChangeLogEntry     = 'Insert ChangeLog entry';
  srkmecInsertCVSAuthor          = 'Insert CVS keyword Author';
  srkmecInsertCVSDate            = 'Insert CVS keyword Date';
  srkmecInsertCVSHeader          = 'Insert CVS keyword Header';
  srkmecInsertCVSID              = 'Insert CVS keyword ID';
  srkmecInsertCVSLog             = 'Insert CVS keyword Log';
  srkmecInsertCVSName            = 'Insert CVS keyword Name';
  srkmecInsertCVSRevision        = 'Insert CVS keyword Revision';
  srkmecInsertCVSSource          = 'Insert CVS keyword Source';
  srkmecInsertGUID               = 'Insert a GUID';

  // search menu
  srkmecFind                      = 'Find text';
  srkmecFindNext                  = 'Find next';
  srkmecFindPrevious              = 'Find previous';
  srkmecFindInFiles               = 'Find in files';
  srkmecReplace                   = 'Replace text';
  lisKMFindIncremental = 'Find incremental';
  srkmecFindProcedureDefinition   = 'Find procedure definiton';
  srkmecFindProcedureMethod       = 'Find procedure method';
  srkmecGotoLineNumber            = 'Go to line number';
  srkmecFindNextWordOccurrence    = 'Find next word occurrence';
  srkmecFindPrevWordOccurrence    = 'Find previous word occurrence';
  srkmecAddJumpPoint              = 'Add jump point';
  lisKMViewJumpHistory = 'View jump history';
  srkmecOpenFileAtCursor          = 'Open file at cursor';
  srkmecGotoIncludeDirective      = 'Go to to include directive of current include file';
  srkmecProcedureList             = 'Procedure List ...';
  
  // view menu
  srkmecToggleFormUnit            = 'Switch between form and unit';
  srkmecToggleObjectInsp          = 'View Object Inspector';
  srkmecToggleSourceEditor        = 'View Source Editor';
  srkmecToggleCodeExpl            = 'View Code Explorer';
  srkmecToggleFPDocEditor         = 'View Documentation Editor';
  srkmecToggleMessages            = 'View messages';
  srkmecToggleSearchResults       = 'View Search Results';
  srkmecToggleWatches             = 'View watches';
  srkmecToggleBreakPoints         = 'View breakpoints';
  srkmecToggleDebuggerOut         = 'View debugger output';
  srkmecToggleLocals              = 'View local variables';
  srkmecTogglecallStack           = 'View call stack';
  srkmecViewUnits                 = 'View units';
  srkmecViewForms                 = 'View forms';
  srkmecViewComponents            = 'View components';
  srkmecViewUnitDependencies      = 'View unit dependencies';
  srkmecViewUnitInfo              = 'View unit information';
  srkmecViewAnchorEditor          = 'View anchor editor';
  srkmecToggleCodeBrowser         = 'View code browser';
  srkmecToggleRestrictionBrowser  = 'View restriction browser';
  srkmecToggleCompPalette         = 'View component palette';
  srkmecToggleIDESpeedBtns        = 'View IDE speed buttons';
  srkmecViewToDoList              = 'View todo list';

  // codetools
  srkmecWordCompletion            = 'Word completion';
  srkmecCompletecode              = 'Complete code';
  srkmecShowCodeContext           = 'Show code context';
  srkmecExtractProc               = 'Extract procedure';
  srkmecFindIdentifierRefs        = 'Find identifier references';
  srkmecRenameIdentifier          = 'Rename identifier';
  srkmecInvertAssignment          = 'Invert assignment';
  srkmecSyntaxCheck               = 'Syntax check';
  srkmecGuessMisplacedIFDEF       = 'Guess misplaced $IFDEF';
  srkmecFindDeclaration           = 'Find declaration';
  srkmecFindBlockOtherEnd         = 'Find block other end';
  srkmecFindBlockStart            = 'Find block start';
  srkmecShowAbstractMethods       = 'Show abstract methods';
  srkmecRemoveEmptyMethods        = 'Remove empty methods';
  srkmecRemoveUnusedUnits         = 'Remove unused units';
  srkmecFindOverloads             = 'Find overloads';

  //Plugin template Edit
  srkmecSynPTmplEdNextCell           = 'Next Cell';
  srkmecSynPTmplEdNextCellSel        = 'Next Cell (all selected)';
  srkmecSynPTmplEdNextCellRotate     = 'Next Cell (rotate)';
  srkmecSynPTmplEdNextCellSelRotate  = 'Next Cell (rotate / all selected)';
  srkmecSynPTmplEdPrevCell           = 'Previous Cell';
  srkmecSynPTmplEdPrevCellSel        = 'Previous Cell (all selected)';
  srkmecSynPTmplEdCellHome           = 'Goto first pos in cell';
  srkmecSynPTmplEdCellEnd            = 'Goto last pos in cell';
  srkmecSynPTmplEdCellSelect         = 'Select cell';
  srkmecSynPTmplEdFinish             = 'Finish';
  srkmecSynPTmplEdEscape             = 'Escape';

  // run menu
  srkmecBuild                     = 'build program/project';
  srkmecBuildAll                  = 'build all files of program/project';
  srkmecQuickCompile              = 'quick compile, no linking';
  srkmecAbortBuild                = 'abort build';
  srkmecRun                       = 'run program';
  srkmecPause                     = 'pause program';
  srkmecStopProgram               = 'stop program';
  srkmecResetDebugger             = 'reset debugger';
  srkmecToggleBreakPoint          = 'toggle break point';
  srkmecRemoveBreakPoint          = 'remove break point';
  srkmecRunParameters             = 'run parameters';
  srkmecCompilerOptions           = 'compiler options';
  srkmecBuildFile                 = 'build file';
  srkmecRunFile                   = 'run file';
  srkmecConfigBuildFile           = 'config build file';
  srkmecInspect                   = 'inspect';
  srkmecEvaluate                  = 'evaluate/modify';
  srkmecAddWatch                  = 'add watch';

  // tools menu
  srkmecExtToolSettings           = 'External tools settings';
  srkmecBuildLazarus              = 'Build lazarus';
  srkmecExtTool                   = 'External tool %d';
  srkmecCustomTool                = 'Custom tool %d';

  // environment menu
  srkmecEnvironmentOptions        = 'IDE options';
  lisKMEditorOptions              = 'Editor options';
  lisKMEditCodeTemplates          = 'Edit Code Templates';
  lisKMCodeToolsOptions           = 'CodeTools options';
  lisKMCodeToolsDefinesEditor     = 'CodeTools defines editor';
  srkmecCodeToolsOptions          = 'Codetools options';
  srkmecCodeToolsDefinesEd        = 'Codetools defines editor';
  lisMenuRescanFPCSourceDirectory = 'Rescan FPC source directory';
  srkmecMakeResourceString        = 'Make resource string';
  lisKMDiffEditorFiles            = 'Diff editor files';
  lisKMConvertDFMFileToLFM        = 'Convert DFM file to LFM';
  lisKMConvertDelphiUnitToLazarusUnit = 'Convert Delphi unit to Lazarus unit';
  lisKMConvertDelphiProjectToLazarusProject = 'Convert Delphi project to '
    +'Lazarus project';
  srkmecDiff                      = 'Diff';
  
  // help menu
  srkmecunknown                   = 'unknown editor command';
   
  // Category
  srkmCatCursorMoving   = 'Cursor moving commands';
  srkmCatSelection      = 'Text selection commands';
  srkmCatColSelection   = 'Text column selection commands';
  srkmCatEditing        = 'Text editing commands';
  lisKMDeleteLastChar   = 'Delete last char';
  srkmCatCmdCmd         = 'Command commands';
  srkmCatSearchReplace  = 'Text search and replace commands';
  srkmCatMarker         = 'Text marker commands';
  srkmCatFold           = 'Text folding commands';
  lisKMSetFreeBookmark = 'Set free Bookmark';
  srkmCatCodeTools      = 'CodeTools commands';
  srkmCatTemplateEdit   = 'Template Editing';
  srkmCatTemplateEditOff= 'Template Editing (not in Cell)';
  srkmCatSrcNoteBook    = 'Source Notebook commands';
  srkmCatFileMenu       = 'File menu commands';
  lisKMGoToSourceEditor10 = 'Go to source editor 10';
  srkmCatViewMenu       = 'View menu commands';
  lisKMToggleViewObjectInspector = 'Toggle view Object Inspector';
  lisKMToggleViewSourceEditor = 'Toggle view Source Editor';
  lisKMToggleViewCodeExplorer = 'Toggle view Code Explorer';
  lisKMToggleViewDocumentationEditor = 'Toggle view Documentation Editor';
  lisKMToggleViewMessages = 'Toggle view Messages';
  lisKMToggleViewSearchResults = 'Toggle view Search Results';
  lisKMToggleViewWatches = 'Toggle view Watches';
  lisKMToggleViewBreakpoints = 'Toggle view Breakpoints';
  lisKMToggleViewLocalVariables = 'Toggle view Local Variables';
  lisKMToggleViewCallStack = 'Toggle view Call Stack';
  lisKMToggleViewDebuggerOutput = 'Toggle view Debugger Output';
  srkmCatProjectMenu    = 'Project menu commands';
  lisKMNewProject = 'New project';
  lisKMNewProjectFromFile = 'New project from file';
  lisKMToggleViewIDESpeedButtons = 'Toggle view IDE speed buttons';
  srkmCatRunMenu        = 'Run menu commands';
  lisKMBuildProjectProgram = 'Build project/program';
  lisKMBuildAllFilesOfProjectProgram = 'Build all files of project/program';
  lisKMQuickCompileNoLinking = 'Quick compile, no linking';
  lisKMAbortBuilding = 'Abort building';
  lisKMRunProgram = 'Run program';
  lisKMPauseProgram = 'Pause program';
  lisKMViewProjectOptions = 'View project options';
  srkmCatPackageMenu = 'Package menu commands';
  srkmCatToolMenu       = 'Tools menu commands';
  lisKMExternalToolsSettings = 'External Tools settings';
  srkmCatEnvMenu        = 'Environment menu commands';
  lisKMConvertDelphiPackageToLazarusPackage = 'Convert Delphi package to '
    +'Lazarus package';
  lisConvertEncodingOfProjectsPackages =
    'Convert encoding of projects/packages';
  srkmCarHelpMenu       = 'Help menu commands';
  lisKeyCatDesigner     = 'Designer commands';
  lisKMCopySelectedComponentsToClipboard = 'Copy selected Components to '
    +'clipboard';
  lisKMCutSelectedComponentsToClipboard =
    'Cut selected Components to clipboard';
  lisKMPasteComponentsFromClipboard = 'Paste Components from clipboard';
  lisKeyCatObjInspector = 'Object Inspector commands';
  lisKeyCatCustom       = 'Custom commands';

  // Languages
  rsLanguageAutomatic   = 'Automatic (or english)';
  rsLanguageEnglish     = 'English';
  rsLanguageGerman      = 'German';
  rsLanguageSpanish     = 'Spanish';
  rsLanguageFrench      = 'French';
  rsLanguageRussian     = 'Russian';
  rsLanguagePolish      = 'Polish';
  rsLanguageItalian     = 'Italian';
  rsLanguageCatalan     = 'Catalan';
  rsLanguageFinnish     = 'Finnish';
  rsLanguageHebrew      = 'Hebrew';
  rsLanguageArabic      = 'Arabic';
  rsLanguagePortugues   = 'Portuguese';
  rsLanguageUkrainian   = 'Ukrainian';
  rsLanguageDutch       = 'Dutch';
  rsLanguageJapanese    = 'Japanese';
  rsLanguageChinese     = 'Chinese';
  rsLanguageIndonesian  = 'Indonesian';
  rsLanguageAfrikaans   = 'Afrikaans';
  rsLanguageLithuanian  = 'Lithuanian';
  rsLanguageSlovak      = 'Slovak';
  rsLanguageTurkish     = 'Turkish';

  // Unit dependencies
  dlgUnitDepCaption     = 'Unit dependencies';
  dlgUnitDepBrowse      = 'Open';
  dlgUnitDepRefresh     = 'Refresh';
  lisPrint = 'Print';
  lisToDoGoto = 'Goto';
  
  // Doc Editor
  lisDocumentationEditor = 'Documentation Editor';
   
  // Build lazarus dialog
  lisConfirmLazarusRebuild = 'Do you want to rebuild Lazarus?';
  lisCleanLazarusSource = 'Clean Lazarus Source';
  lisMakeNotFound = 'Make not found';
  lisTheProgramMakeWasNotFoundThisToolIsNeededToBuildLa = 'The program %smake%'
    +'s was not found.%sThis tool is needed to build lazarus.%s';
  lisCompileIDEWithoutLinking = 'Compile IDE (without linking)';
  lisLCL = 'LCL';
  lisComponent = 'Component';
  lisCodeTools = 'CodeTools';
  lisSynEdit = 'SynEdit';
  lisIDEIntf = 'IDE Interface';
  lisJITForm = 'JIT Form';
  lisPkgReg = 'Package Registration';
  lisIDE = 'IDE';
  lisExamples = 'Examples';
  lisConfigureBuildLazarus = 'Configure %sBuild Lazarus%s';
  lisLazBuildCleanAll = 'Clean all';
  lisLazBuildBuildComponentsSynEditCodeTools = 'Build components (SynEdit, '
    +'CodeTools)';
  lisLazBuildBuildSynEdit = 'Build SynEdit';
  lisLazBuildBuildCodeTools = 'Build CodeTools';
  lisLazBuildBuildIDE = 'Build IDE';
  lisLazBuildBuildExamples = 'Build examples';
  lisLazBuildOptions = 'Options:';
  lisLazBuildTargetOS = 'Target OS:';
  lisLazBuildTargetCPU = 'Target CPU:';
  lisLazBuildTargetDirectory = 'Target directory:';
  lisLazBuildLCLInterface = 'LCL interface';
  lisLazBuildBuildJITForm = 'Build JITForm';
  lisLazBuildWithStaticPackages = 'With packages';
  lisLazBuildRestartAfterBuild = 'Restart after successful Build';
  lisLazBuildConfirmBuild = 'Confirm before rebuilding Lazarus';
  lisLazBuildOk = 'Ok';
  lisCTDTemplates = 'Templates';
  lisSaveSettings = 'Save Settings';
  lisLazBuildCancel = 'Cancel';
  lisLazBuildNone = 'None';
  lisLazBuildBuild = 'Build';
  lisLazBuildCleanBuild = 'Clean+Build';
  lisLazBuildBuildOptions ='Build Options';
  lisLazBuildErrorWritingFile = 'Error writing file';
  lisLazBuildUnableToWriteFile = 'Unable to write file "%s":%s';
  lisLazBuildQuickBuildOptions = 'Quick Build Options';
  lisLazBuildQBOBuildLCL = 'Build LCL';
  lisLazBuildQBOBuildIDEwPackages = 'Build IDE with Packages';
  lisLazBuildQBOBuildIDEwithoutPackages = 'Build IDE without Packages';
  lisLazBuildQBOBuildAll = 'Build All';
  lisLazBuildQBOCleanUpBuildAll = 'Clean Up + Build all';
  lisLazBuildQBOBuildOther = 'Other';
  lisLazBuildQBOAppLCLTarget = 'Target';
  lisLazBuildAdvancedBuildOptions = 'Advanced Build Options';
  lisLazBuildABOPart = 'Part';
  lisLazBuildABOAction = 'Action';
  lisLazBuildABOChooseOutputDir = 'Choose output directory of the IDE executable ';
  
  // compiler
  lisCompilerErrorInvalidCompiler = 'Error: invalid compiler: %s';
  listCompilerInternalError = 'Internal compiler error! (%d)';
  lisCompilerHintYouCanSetTheCompilerPath = 'Hint: you can set the compiler '
    +'path in Environment->Environment options->Files->Compiler Path';
  lisCompilerNOTELoadingOldCodetoolsOptionsFile = 'NOTE: loading old '
    +'codetools options file: ';
  lisCompilerNOTECodetoolsConfigFileNotFoundUsingDefaults = 'NOTE: codetools '
    +'config file not found - using defaults';
     
  // codetools options dialog
  lisCodeToolsOptsOk          = 'Ok';
  lisCodeToolsOptsNone        = 'None';
  lisCodeToolsOptsKeyword     = 'Keyword';
  lisCodeToolsOptsIdentifier  = 'Identifier';
  lisFRIAdditionalFilesToSearchEGPathPasPath2Pp = 'Additional files to '
    +'search (e.g. /path/*.pas;/path2/*.pp)';
  lisFRIFindReferences = 'Find References';
  lisFRIInvalidIdentifier = 'Invalid Identifier';
  lisFRIRenameTo = 'Rename to';
  lisFRIRename = 'Rename';
  lisFRISearchInCommentsToo = 'Search in comments too';
  lisFRISearchWhere = 'Search where';
  lisCodeToolsOptsColon       = 'Colon';
  lisCodeToolsOptsSemicolon   = 'Semicolon';
  lisCodeToolsOptsComma       = 'Comma';
  lisCodeToolsOptsPoint       = 'Point';
  lisCodeToolsOptsAt          = 'At';
  lisCodeToolsOptsNumber      = 'Number';
  lisCodeToolsOptsStringConst = 'String constant';
  lisCodeToolsOptsNewLine     = 'Newline';
  lisCodeToolsOptsSpace       = 'Space';
  lisCodeToolsOptsSymbol      = 'Symbol';
  lisCodeToolsOptsBracket     = 'Bracket';

  // codetools defines
  lisCodeToolsDefsCodeToolsDefinesPreview = 'CodeTools Defines Preview';
  lisCodeToolsDefsWriteError = 'Write error';
  lisStopDebugging2 = 'Stop debugging?';
  lisStopCurrentDebuggingAndRebuildProject = 'Stop current debugging and '
    +'rebuild project?';
  lisErrorWritingPackageListToFile = 'Error writing package list to file%s%s%'
    +'s%s';
  lisCodeToolsDefsErrorWhileWriting = 'Error while writing %s%s%s%s%s';
  lisCodeToolsDefsErrorWhileWritingProjectInfoFile = 'Error while writing '
    +'project info file %s%s%s%s%s';
  lisCodeToolsDefsReadError = 'Read error';
  lisUnableToRead = 'Unable to read %s';
  lisErrorReadingPackageListFromFile = 'Error reading package list from file%'
    +'s%s%s%s';
  lisTheCurrentUnitPathForTheFileIsThePathToTheLCLUnits = 'The current unit '
    +'path for the file%s%s%s%s is%s%s%s%s.%s%sThe path to the LCL units %s%s%'
    +'s is missing.%s%sHint for newbies:%sCreate a lazarus application and '
    +'put the file into the project directory.';
  lisLCLUnitPathMissing = 'LCL unit path missing';
  lisNotADelphiUnit = 'Not a Delphi unit';
  lisTheFileIsNotADelphiUnit = 'The file %s%s%s is not a Delphi unit.';
  lisCodeToolsDefsErrorReading = 'Error reading %s%s%s%s%s';
  lisCodeToolsDefsErrorReadingProjectInfoFile = 'Error reading project info '
    +'file %s%s%s%s%s';
  lisCodeToolsDefsNodeIsReadonly = 'Node is readonly';
  lisCodeToolsDefsAutoGeneratedNodesCanNotBeEdited = 'Auto generated nodes '
    +'can not be edited.';
  lisCodeToolsDefsInvalidPreviousNode = 'Invalid previous node';
  lisCodeToolsDefsPreviousNodeCanNotContainChildNodes = 'Previous node can '
    +'not contain child nodes.';
  lisCodeToolsDefsCreateFPCMacrosAndPathsForAFPCProjectDirectory = 'Create '
    +'FPC Macros and paths for a fpc project directory';
  lisCodeToolsDefsProjectDirectory = 'Project directory';
  lisCodeToolsDefsTheFreePascalProjectDirectory = 'The Free Pascal project '
    +'directory.';
  lisCodeToolsDefscompilerPath = 'compiler path';
  lisCodeToolsDefsThePathToTheFreePascalCompilerForThisProject = 'The path to '
    +'the free pascal compiler for this project. Only required if you set the '
    +'FPC SVN source below. Used to autocreate macros.';
  lisCodeToolsDefsFPCSVNSourceDirectory = 'FPC SVN source directory';
  lisCodeToolsDefsTheFreePascalCVSSourceDirectory = 'The Free Pascal SVN '
    +'source directory. Not required. This will improve find declarationand '
    +'debugging.';
  lisCodeToolsDefsCreateDefinesForFreePascalCompiler = 'Create Defines for '
    +'Free Pascal Compiler';
  lisCodeToolsDefsThePathToTheFreePascalCompilerForExample = 'The '
    +'path to the free pascal compiler.%s For example %s/usr/bin/%s -n%s '
    +'or %s/usr/local/bin/fpc @/etc/fpc.cfg%s.';
  lisCodeToolsDefsCreateDefinesForFreePascalSVNSources = 'Create Defines for '
    +'Free Pascal SVN Sources';
  lisCodeToolsDefsTheFreePascalSVNSourceDir = 'The Free Pascal SVN source '
    +'directory.';
  lisCodeToolsDefsCreateDefinesForLazarusDir = 'Create Defines for Lazarus '
    +'Directory';
  lisCodeToolsDefsLazarusDirectory = 'Lazarus Directory';
  lisCodeToolsDefsTheLazarusMainDirectory = 'The Lazarus main directory.';
  lisCodeToolsDefsCreateDefinesForDirectory = 'Create Defines for %s Directory';
  lisCodeToolsDefsdirectory = '%s directory';
  lisCodeToolsDefsDelphiMainDirectoryDesc = 'The %s main directory,%swhere '
    +'Borland has installed all %s sources.%sFor example: C:/Programme/'
    +'Borland/Delphi%s';
  lisCodeToolsDefsKylixMainDirectoryDesc = 'The %s main directory,%swhere '
    +'Borland has installed all %s sources.%sFor example: /home/user/kylix%s';
  lisCodeToolsDefsCreateDefinesForProject = 'Create Defines for %s Project';
  lisCodeToolsDefsprojectDirectory2 = '%s project directory';
  lisCodeToolsDefsTheProjectDirectory = 'The %s project directory,%swhich '
    +'contains the .dpr, dpk file.';
  lisCodeToolsDefsDelphiMainDirectoryForProject = 'The %s main directory,%'
    +'swhere Borland has installed all %s sources,%swhich are used by this %s '
    +'project.%sFor example: C:/Programme/Borland/Delphi%s';
  lisCodeToolsDefsKylixMainDirectoryForProject = 'The %s main directory,%'
    +'swhere Borland has installed all %s sources,%swhich are used by this %s '
    +'project.%sFor example: /home/user/kylix%s';
  lisCodeToolsDefsExit = 'Exit';
  lisCodeToolsDefsSaveAndExit = 'Save and Exit';
  lisCodeToolsDefsExitWithoutSave = 'Exit without Save';
  lisCodeToolsDefsEdit = 'Edit';
  lisCodeToolsDefsMoveNodeUp = 'Move node up';
  lisCodeToolsDefsMoveNodeDown = 'Move node down';
  lisCodeToolsDefsMoveNodeOneLevelUp = 'Move node one level up';
  lisCodeToolsDefsMoveNodeOneLevelDown = 'Move node one level down';
  lisCodeToolsDefsInsertNodeBelow = 'Insert node below';
  lisCodeToolsDefsInsertNodeAsChild = 'Insert node as child';
  lisCodeToolsDefsDeleteNode = 'Delete node';
  lisCodeToolsDefsConvertNode = 'Convert node';
  lisCodeToolsDefsDefine = 'Define';
  lisCodeToolsDefsDefineRecurse = 'Define Recurse';
  lisCodeToolsDefsUndefine = 'Undefine';
  lisCodeToolsDefsUndefineRecurse = 'Undefine Recurse';
  lisCodeToolsDefsUndefineAll = 'Undefine All';
  lisCodeToolsDefsBlock = 'Block';
  lisCodeToolsDefsInsertBehindDirectory = 'Directory';
  lisCodeToolsDefsIf = 'If';
  lisCodeToolsDefsIfDef = 'IfDef';
  lisCodeToolsDefsIfNDef = 'IfNDef';
  lisCodeToolsDefsElseIf = 'ElseIf';
  lisCodeToolsDefsElse = 'Else';
  lisCTDefsTools = 'Tools';
  lisCTDefsOpenPreview = 'Open Preview';
  lisCodeToolsDefsInsertTemplate = 'Insert Template';
  lisCodeToolsDefsInsertFreePascalProjectTe = 'Insert Free Pascal Project '
    +'Template';
  lisCodeToolsDefsInsertFreePascalCompilerT = 'Insert Free Pascal Compiler '
    +'Template';
  lisCodeToolsDefsInsertFreePascalSVNSource = 'Insert Free Pascal SVN Source '
    +'Template';
  lisCodeToolsDefsInsertLazarusDirectoryTem = 'Insert Lazarus Directory '
    +'Template';
  lisCodeToolsDefsInsertDelphi5CompilerTemp = 'Insert Delphi 5 Compiler '
    +'Template';
  lisCodeToolsDefsInsertDelphi5DirectoryTem = 'Insert Delphi 5 Directory '
    +'Template';
  lisCodeToolsDefsInsertDelphi5ProjectTempl =
    'Insert Delphi 5 Project Template';
  lisCodeToolsDefsInsertDelphi6CompilerTemp = 'Insert Delphi 6 Compiler '
    +'Template';
  lisCodeToolsDefsInsertDelphi6DirectoryTem = 'Insert Delphi 6 Directory '
    +'Template';
  lisCodeToolsDefsInsertDelphi6ProjectTempl =
    'Insert Delphi 6 Project Template';
  lisCodeToolsDefsInsertDelphi7CompilerTemp = 'Insert Delphi 7 Compiler '
    +'Template';
  lisCodeToolsDefsInsertDelphi7DirectoryTem = 'Insert Delphi 7 Directory '
    +'Template';
  lisCodeToolsDefsInsertDelphi7ProjectTempl =
    'Insert Delphi 7 Project Template';
  lisCodeToolsDefsInsertKylix3CompilerTemp = 'Insert Kylix 3 Compiler '
    +'Template';
  lisCodeToolsDefsInsertKylix3DirectoryTem = 'Insert Kylix 3 Directory '
    +'Template';
  lisCodeToolsDefsInsertKylix3ProjectTempl =
    'Insert Kylix 3 Project Template';
  lisCodeToolsDefsSelectedNode = 'Selected Node:';
  lisCodeToolsDefsNodeAndItsChildrenAreOnly = 'Node and its children are only '
    +'valid for this project';
  lisCodeToolsDefsName = 'Name:';
  lisCodeToolsDefsDescription = 'Description:';
  lisCodeToolsDefsVariable = 'Variable:';
  lisAddValue = 'Add value:';
  lisCodeToolsDefsValueAsText = 'Value as Text';
  lisCodeToolsDefsValueAsFilePaths = 'Value as File Paths';
  lisCodeToolsDefsAction = 'Action: %s';
  lisCodeToolsDefsautoGenerated = '%s, auto generated';
  lisCodeToolsDefsprojectSpecific = '%s, project specific';
  lisCodeToolsDefsnoneSelected = 'none selected';
  lisCodeToolsDefsInvalidParent = 'Invalid parent';
  lisACanNotHoldTControlsYouCanOnlyPutNonVisualComponen = 'A %s can not hold '
    +'TControls.%sYou can only put non visual components on it.';
  lisUpdateReferences = 'Update references?';
  lisTheUnitIsUsedByOtherFilesUpdateReferencesAutomatic = 'The unit %s is '
    +'used by other files.%sUpdate references automatically?';
  lisCodeToolsDefsAutoCreatedNodesReadOnly = 'Auto created nodes can not be '
    +'edited,%snor can they have non auto created child nodes.';
  lisCodeToolsDefsInvalidParentNode = 'Invalid parent node';
  lisCodeToolsDefsParentNodeCanNotContainCh = 'Parent node can not contain '
    +'child nodes.';
  lisCodeToolsDefsNewNode = 'NewNode';
  lisCodeToolsDefsCodeToolsDefinesEditor = 'CodeTools Defines Editor';
  
  // code template dialog
  lisCodeTemplAddCodeTemplate = 'Add code template';
  lisCodeTemplAdd = 'Add';
  lisCodeTemplEditCodeTemplate = 'Edit code template';
  lisCodeTemplAutoCompleteOn = 'Auto complete on ...';
  lisCodeTemplChange = 'Change';
  lisCodeTemplToken = 'Token:';
  lisCodeTemplComment = 'Comment:';
  lisCodeTemplATokenAlreadyExists = ' A token %s%s%s already exists! ';
  lisCodeTemplError = 'Error';
  lisUnableToOpenDesignerTheClassDoesNotDescendFromADes = 'Unable to open '
    +'designer.%sThe class %s does not descend from a designable class like '
    +'TForm or TDataModule.';
  lisClassConflictsWithLfmFileTheUnitUsesTheUnitWhic = 'Class conflicts '
    +'with .lfm file:%sThe unit %s%suses the unit %s%swhich contains the '
    +'class %s,%sbut the .lfm file contains already another class.%sThere can '
    +'only be one design class per unit.%sPlease move %s to another unit.';
  lisUnableToFindTheUnitOfComponentClass = 'Unable to find the unit of '
    +'component class %s%s%s.';
  lisUnableToLoadTheComponentClassBecauseItDependsOnIts = 'Unable to load the '
    +'component class %s%s%s, because it depends on itself.';
  lisCancelLoadingThisComponent = 'Cancel loading this component';
  lisAbortWholeLoading = 'Abort whole loading';
  lisIgnoreUseTFormAsAncestor = 'Ignore, use TForm as ancestor';
  lisTheResourceClassDescendsFromProbablyThisIsATypoFor = 'The resource '
    +'class %s%s%s descends from %s%s%s. Probably this is a typo for TForm.';

  // make resource string dialog
  lisMakeResourceString = 'Make ResourceString';
  lisMakeResStrInvalidResourcestringSect = 'Invalid Resourcestring section';
  lisMakeResStrPleaseChooseAResourcestring = 'Please choose a resourcestring '
    +'section from the list.';
  lisMakeResStrResourcestringAlreadyExis = 'Resourcestring already exists';
  lisMakeResStrChooseAnotherName = 'The resourcestring %s%s%s already exists.%'
    +'sPlease choose another name.%sUse Ignore to add it anyway.';
  lisMakeResStrStringConstantInSource = 'String constant in source';
  lisMakeResStrConversionOptions = 'Conversion Options';
  lisMakeResStrIdentifierPrefix = 'Identifier prefix:';
  lisMakeResStrIdentifierLength = 'Identifier length:';
  lisMakeResStrDialogIdentifier = 'Identifier';
  lisMakeResStrCustomIdentifier = 'Custom identifier';
  lisMakeResStrResourcestringSection = 'Resourcestring section:';
  lisMakeResStrStringsWithSameValue = 'Strings with same value:';
  lisMakeResStrAppendToSection = 'Append to section';
  lisMakeResStrInsertAlphabetically = 'Insert alphabetically';
  lisMakeResStrInsertContexttSensitive = 'Insert context sensitive';
  lisMakeResStrSourcePreview = 'Source preview';
  lisNoStringConstantFound = 'No string constant found';
  lisSuccess = 'Success';
  lisAllBlocksLooksOk = 'All blocks looks ok.';
  lisHintTheMakeResourcestringFunctionExpectsAStringCon = 'Hint: The "Make '
    +'Resourcestring" function expects a string constant.%sPlease select the '
    +'expression and try again.';

  // diff dialog
  lisDiffDlgText1 = 'Text1';
  lisDiffDlgOnlySelection = 'Only selection';
  lisDiffDlgText2 = 'Text2';
  lisDiffDlgCaseInsensitive = 'Case Insensitive';
  lisDiffDlgIgnoreIfEmptyLinesWereAdd = 'Ignore if empty lines were added or '
    +'removed';
  lisDiffDlgIgnoreSpacesAtStartOfLine = 'Ignore spaces at start of line';
  lisDiffDlgIgnoreSpacesAtEndOfLine = 'Ignore spaces at end of line';
  lisDiffDlgIgnoreIfLineEndCharsDiffe = 'Ignore difference in line ends (e.'
    +'g. #10 = #13#10)';
  lisDiffDlgIgnoreIfSpaceCharsWereAdd = 'Ignore amount of space chars';
  lisDiffDlgIgnoreSpaces = 'Ignore spaces (newline chars not included)';
  lisDiffDlgOpenDiffInEditor = 'Open Diff in editor';
  lisSave = 'Save ...';

  // todolist
  lisTodoListCaption='ToDo List';
  lisTodolistRefresh='Refresh todo items';
  lisTodoListGotoLine='Goto selected source line';
  lisTodoListPrintList='Print todo items';
  lisToDoListOptions='ToDo options...';
  lisCTInsertMacro = 'Insert Macro';
  lisToDoLDone = 'Done';
  lisToDoLDescription = 'Description';
  lisToDoLPriority = 'Priority';
  lisToDoLFile  = 'Module';
  lisToDoLLine  = 'Line';
  lisToDoLOwner = 'Owner';
  listToDoLCategory = 'Category';

  // packages
  lisPkgFileTypeUnit = 'Unit';
  lisPkgFileTypeVirtualUnit = 'Virtual Unit';
  lisPkgFileTypeLFM = 'LFM - Lazarus form text';
  lisPkgFileTypeLRS = 'LRS - Lazarus resource';
  lisPkgFileTypeInclude = 'Include file';
  lisPkgFileTypeIssues = 'Issues xml file';
  lisPkgFileTypeText = 'Text';
  lisPkgFileTypeBinary = 'Binary';

  // view project units dialog
  lisViewProjectUnits = 'View Project Units';
  
  // unit info dialog
  lisInformationAboutUnit = 'Information about %s';
  lisUIDyes = 'yes';
  lisUIDno = 'no';
  lisUIDbytes = '%s bytes';
  lisUIDName = 'Name:';
  lisUIDType = 'Type:';
  lisUIDinProject = 'in Project:';
  lisUIDIncludedBy = 'Included by:';
  lisUIDClear = 'Clear';
  lisUIDPathsReadOnly = 'Paths (Read Only)';
  lisUIDUnit = 'Unit';
  lisUIDSrc = 'Src';
  lisUIDOk = 'Ok';
  lisUIDSize = 'Size:';
  lisUIDLines = 'Lines:';
  lisUIShowCodeToolsValues = 'Show CodeTools Values';
  
  // unit editor
  lisUEErrorInRegularExpression = 'Error in regular expression';
  lisSearchFor = 'Search For ';
  lisUENotFound = 'Not found';
  lisUESearchStringNotFound = 'Search string ''%s'' not found!';
  lisUEReplaceThisOccurrenceOfWith = 'Replace this occurrence of %s%s%s%s '
    +'with %s%s%s?';
  lisUESearching = 'Searching: %s';
  lisUEReadOnly = '%s/ReadOnly';
  lisUEGotoLine = 'Goto line :';
  
  // Transfer Macros
  lisTMFunctionExtractFileExtension = 'Function: extract file extension';
  lisTMFunctionExtractFilePath = 'Function: extract file path';
  lisTMFunctionExtractFileNameExtension = 'Function: extract file name+'
    +'extension';
  lisTMFunctionExtractFileNameOnly = 'Function: extract file name only';
  lisTMFunctionAppendPathDelimiter = 'Function: append path delimiter';
  lisTMFunctionChompPathDelimiter = 'Function: chomp path delimiter';
  lisTMunknownMacro = '(unknown macro: %s)';
  
  // System Variables Override Dialog
  lisSVUOInvalidVariableName = 'Invalid variable name';
  lisSVUOisNotAValidIdentifier = '%s%s%s is not a valid identifier.';
  lisFRIIdentifier = 'Identifier: %s';
  lisSVUOOverrideSystemVariable = 'Override system variable';
  lisSVUOOk = 'Ok';
  
  // sort selection dialog
  lisSortSelSortSelection = 'Sort selection';
  lisSortSelPreview = 'Preview';
  lisSortSelAscending = 'Ascending';
  lisSortSelDescending = 'Descending';
  lisSortSelDomain = 'Domain';
  lisSortSelLines = 'Lines';
  lisSortSelWords = 'Words';
  lisSortSelParagraphs = 'Paragraphs';
  lisSortSelOptions = 'Options';
  lisSortSelCaseSensitive = '&Case Sensitive';
  lisSortSelIgnoreSpace = 'Ignore Space';
  lisSortSelSort = 'Accept';
  lisSortSelCancel = 'Cancel';

  // publish project dialog
  lisPublProjInvalidIncludeFilter = 'Invalid Include filter';
  lisPublProjInvalidExcludeFilter = 'Invalid Exclude filter';

  // project options
  lisProjOptsUnableToChangeTheAutoCreateFormList = 'Unable to change the auto '
    +'create form list in the program source.%sPlease fix errors first.';
  lisProjOptsError = 'Error';
  
  // path edit dialog
  lisPathEditSelectDirectory = 'Select directory';
  lisPathEditSearchPaths = 'Search paths:';
  lisPathEditMovePathDown = 'Move path down';
  lisPathEditMovePathUp = 'Move path up';
  lisPathEditBrowse = 'Browse';
  lisPathEditPathTemplates = 'Path templates';
  
  // new dialog
  lisNewDlgNoItemSelected = 'No item selected';
  lisErrorOpeningComponent = 'Error opening component';
  lisUnableToOpenAncestorComponent = 'Unable to open ancestor component';
  lisNewDlgPleaseSelectAnItemFirst = 'Please select an item first.';
  lisNewDlgCreateANewEditorFileChooseAType = 'Create a new editor file.%'
    +'sChoose a type.';
  lisNewDlgCreateANewProjectChooseAType = 'Create a new project.%sChoose a '
    +'type.';
  lisChooseOneOfTheseItemsToCreateANewFile = 'Choose one of these items to '
    +'create a new File';
  lisChooseOneOfTheseItemsToInheritFromAnExistingOne = 'Choose one of these items to '
    +'inherit from an existing one';
  lisInheritedItem = 'Inherited Item';
  lisChooseOneOfTheseItemsToCreateANewProject = 'Choose one of these items to '
    +'create a new Project';
  lisChooseOneOfTheseItemsToCreateANewPackage = 'Choose one of these items to '
    +'create a new Package';
  lisPackage = 'Package';
  lisNewDlgCreateANewPascalUnit = 'Create a new pascal unit.';
  lisNewDlgCreateANewUnitWithALCLForm = 'Create a new unit with a LCL form.';
  lisNewDlgCreateANewUnitWithADataModule = 'Create a new unit with a datamodule.';
  lisNewDlgCreateANewUnitWithAFrame = 'Create a new unit with a frame';
  lisNewDlgCreateANewEmptyTextFile = 'Create a new empty text file.';
  lisNewDlgInheritAnExistingComponent = 'Inherit from an existing component.';
  lisASimplePascalProgramFileThisCanBeUsedForQuickAndDi = 'A simple Pascal '
    +'Program file.%sThis can be used for quick and dirty testing.%sBetter '
    +'create a new project.';
  lisNewDlgCreateANewGraphicalApplication = 'Create a new '
    +'graphical application.%sThe program file is maintained by Lazarus.';
  lisNewDlgCreateANewProgram = 'Create a new '
    +'program.%sThe program file is maintained by Lazarus.';
  lisNewDlgCreateANewCustomProgram = 'Create a new program.';
  lisNewCreateANewCgiApplicationTheProgramFileIsMaintained = 'Create a new '
    +'cgi application.%sThe program file is maintained by Lazarus.';
  lisNewDlgCreateANewStandardPackageAPackageIsACollectionOfUn = 'Create a new '
    +'standard package.%sA package is a collection of units and components.';

  // file checks
  lisUnableToCreateFile = 'Unable to create file';
  lisCanNotCreateFile = 'Can not create file %s%s%s';
  lisExtendUnitPath = 'Extend unit path?';
  lisTheDirectoryIsNotYetInTheUnitPathAddIt = 'The directory %s%s%s is not '
    +'yet in the unit path.%sAdd it?';
  lisUnableToCreateFilename = 'Unable to create file %s%s%s.';
  lisUnableToWriteFile = 'Unable to write file';
  lisUnableToWriteFile2 = 'Unable to write file %s%s%s';
  lisFileIsNotWritable = 'File is not writable';
  lisUnableToWriteToFile2 = 'Unable to write to file %s%s%s';
  lisUnableToWriteFilename = 'Unable to write file %s%s%s.';
  lisUnableToReadFile = 'Unable to read file';
  lisUnableToReadFilename = 'Unable to read file %s%s%s.';
  lisErrorDeletingFile = 'Error deleting file';
  lisUnableToDeleteAmbiguousFile = 'Unable to delete ambiguous file %s%s%s';
  lisErrorRenamingFile = 'Error renaming file';
  lisUnableToRenameAmbiguousFileTo = 'Unable to rename ambiguous file %s%s%s%'
    +'sto %s%s%s';
  lisWarningAmbiguousFileFoundSourceFileIs = 'Warning: ambiguous file found: %'
    +'s%s%s. Source file is: %s%s%s';
  lisAmbiguousFileFound = 'Ambiguous file found';
  lisThereIsAFileWithTheSameNameAndASimilarExtension = 'There is a file with '
    +'the same name and a similar extension ond disk%sFile: %s%sAmbiguous '
    +'File: %s%s%sDelete ambiguous file?';

  // add to project dialog
  lisProjAddInvalidMinMaxVersion = 'Invalid Min-Max version';
  lisProjAddTheMaximumVersionIsLowerThanTheMinimimVersion = 'The Maximum '
    +'Version is lower than the Minimim Version.';
  lisProjAddInvalidPackagename = 'Invalid packagename';
  lisProjAddThePackageNameIsInvalidPlaseChooseAnExistingPackag = 'The package '
    +'name %s%s%s is invalid.%sPlase choose an existing package.';
  lisProjAddDependencyAlreadyExists = 'Dependency already exists';
  lisProjAddTheProjectHasAlreadyADependency = 'The project has already a '
    +'dependency for the package %s%s%s.';
  lisProjAddPackageNotFound = 'Package not found';
  lisLDTheUnitIsNotOwnedBeAnyPackageOrProjectPleaseAddThe = 'The unit %s is '
    +'not owned be any package or project.%sPlease add the unit to a package '
    +'or project.%sUnable to create the fpdoc file.';
  lisLDNoValidLazDocPath = 'No valid LazDoc path';
  lisLDDoesNotHaveAnyValidLazDocPathUnableToCreateTheFpdo = '%s does not have '
    +'any valid LazDoc path.%sUnable to create the fpdoc file for %s';
  lisErrorReadingXML = 'Error reading XML';
  lisErrorReadingXmlFile = 'Error reading xml file %s%s%s%s%s';
  lisPkgThisFileIsNotInAnyLoadedPackage = 'This file is not in any loaded '
    +'package.';
  lisProjAddTheDependencyWasNotFound = 'The dependency %s%s%s was not found.%'
    +'sPlease choose an existing package.';
  lisProjAddInvalidVersion = 'Invalid version';
  lisProjAddTheMinimumVersionIsInvalid = 'The Minimum Version %s%s%s is '
    +'invalid.%sPlease use the format major.minor.release.build%sFor '
    +'exmaple: 1.0.20.10';
  lisProjAddTheMaximumVersionIsInvalid = 'The Maximum Version %s%s%s is '
    +'invalid.%sPlease use the format major.minor.release.build%sFor '
    +'exmaple: 1.0.20.10';
  lisProjAddInvalidPascalUnitName = 'Invalid pascal unit name';
  lisProjAddTheUnitNameIsNotAValidPascalIdentifier = 'The unit name %s%s%s is '
    +'not a valid pascal identifier.';
  lisProjAddUnitNameAlreadyExists = 'Unit name already exists';
  lisProjAddTheUnitNameAlreadyExistsInTheProject = 'The unit name %s%s%s '
    +'already exists in the project%swith file: %s%s%s.';
  lisProjAddTheUnitNameAlreadyExistsInTheSelection = 'The unit name %s%s%s '
    +'already exists in the selection%swith file: %s%s%s.';
  lisProjAddToProject = 'Add to project';
  lisProjAddNewRequirement = 'New Requirement';
  lisProjAddFiles = 'Add files';
  lisProjAddEditorFile = 'Add editor files';
  lisProjAddAddFileToProject = 'Add file to project:';
  lisProjAddAddFilesToProject = 'Add files to project';
  lisProjAddPackageName = 'Package Name:';
  lisProjAddMinimumVersionOptional = 'Minimum Version (optional):';
  lisProjAddMaximumVersionOptional = 'Maximum Version (optional):';
  
  // component palette
  lisKMNewPackage = 'New package';
  lisCompPalOpenPackage = 'Open package';
  lisKMOpenPackageFile = 'Open package file';
  lisCPOpenPackage = 'Open Package %s';
  lisCPOpenUnit = 'Open Unit %s';
  lisCompPalOpenUnit = 'Open unit';
  lisCompPalFindComponent = 'Find component';

  // macro promp dialog
  lisMacroPromptEnterData = 'Enter data';
  lisMacroPromptEnterRunParameters = 'Enter run parameters';
  
  // debugger
  lisDebuggerError = 'Debugger error';
  lisDebuggerErrorOoopsTheDebuggerEnteredTheErrorState = 'Debugger error%'
    +'sOoops, the debugger entered the error state%sSave your work now !%sHit '
    +'Stop, and hope the best, we''re pulling the plug.';
  lisExecutionStopped = 'Execution stopped';
  lisExecutionStoppedOn = 'Execution stopped%s';
  lisExecutionPaused = 'Execution paused';
  lisExecutionPausedAdress = 'Execution paused%s  Adress: $%s%s  Procedure: %'
    +'s%s  File: %s%s(Some day an assembler window might popup here :)%s';
  lisFileNotFound = 'File not found';
  lisCleanUpUnitPath = 'Clean up unit path?';
  lisTheDirectoryIsNoLongerNeededInTheUnitPathRemoveIt = 'The directory %s%s%'
    +'s is no longer needed in the unit path.%sRemove it?';
  lisTheFileWasNotFoundDoYouWantToLocateItYourself = 'The file %s%s%s%swas '
    +'not found.%sDo you want to locate it yourself ?%s';
  lisRunToFailed = 'Run-to failed';
  lisDbgMangNoDebuggerSpecified = 'No debugger specified';
  lisDbgMangThereIsNoDebuggerSpecifiedSettingBreakpointsHaveNo = 'There is no '
    +'debugger specified.%sSetting breakpoints have no effect until you setup '
    +'a Debugger in the debugger options dialog in the menu.';
  lisDbgMangSetTheBreakpointAnyway = 'Set the breakpoint anyway';
  lisLaunchingApplicationInvalid = 'Launching application invalid';
  lisTheLaunchingApplicationDoesNotExistsOrIsNotExecuta = 'The launching '
    +'application %s%s%'
    +'s%sdoes not exist or is not executable.%s%sSee Run -> Run parameters -> '
    +'Local';
  lisTheLaunchingApplicationBundleDoesNotExists = 'The Application Bundle %s'
    +'%sneeded for execution does not exist or is not executable.%sDo you want to create one?'
    +'%s%sSee Project -> Project Options -> Application for settings.';

  lisDebuggerInvalid = 'Debugger invalid';
  lisTheDebuggerDoesNotExistsOrIsNotExecutableSeeEnviro = 'The debugger %s%s%'
    +'s%sdoes not exist or is not executable.%s%sSee Environment -> Debugger '
    +'Options';
  lisUnableToRun = 'Unable to run';
  lisTheDestinationDirectoryDoesNotExistPleaseCheckTheP = 'The destination '
    +'directory %s%s%s does not exist.%sPlease check the project target file '
    +'name Menu > Project > Project Options.';
  lisTheWorkingDirectoryDoesNotExistPleaseCheckTheWorki = 'The working '
    +'directory %s%s%s does not exist.%sPlease check the working directory in '
    +'Menu > Run > Run parameters.';
  lisPleaseOpenAUnitBeforeRun = 'Please open a unit before run.';
  
  // disk diff dialog
  lisDiskDiffErrorReadingFile = 'Error reading file: %s';
  lisDiskDiffSomeFilesHaveChangedOnDisk = 'Some files have changed on disk:';
  lisDiskDiffChangedFiles = 'Changed files:';
  lisDiskDiffClickOnOneOfTheAboveItemsToSeeTheDiff = 'Click on one of the '
    +'above items to see the diff';
  lisDiskDiffRevertAll = 'Reload from disk';
  lisDiskDiffIgnoreDiskChanges = 'Ignore disk changes';
  
  // edit define tree
  lisEdtDefCurrentProject = 'Current Project';
  lisEdtDefCurrentProjectDirectory = 'Current Project Directory';
  lisEdtDefProjectSrcPath = 'Project SrcPath';
  lisEdtDefProjectIncPath = 'Project IncPath';
  lisEdtDefProjectUnitPath = 'Project UnitPath';
  lisEdtDefAllPackages = 'All packages';
  lisEdtDefsAllProjects = 'All projects';
  lisEdtDefsetFPCModeToDELPHI = 'set FPC mode to DELPHI';
  lisEdtDefsetFPCModeToTP = 'set FPC mode to TP';
  lisEdtDefsetFPCModeToGPC = 'set FPC mode to GPC';
  lisEdtDefsetFPCModeToMacPas = 'set FPC mode to MacPas';
  lisEdtDefsetFPCModeToFPC = 'set FPC mode to FPC';
  lisEdtDefsetIOCHECKSOn = 'set IOCHECKS on';
  lisEdtDefsetRANGECHECKSOn = 'set RANGECHECKS on';
  lisEdtDefsetOVERFLOWCHECKSOn = 'set OVERFLOWCHECKS on';
  lisEdtDefuseLineInfoUnit = 'use LineInfo unit';
  lisEdtDefuseHeapTrcUnit = 'use HeapTrc unit';
  lisEdtDefGlobalSourcePathAddition = 'Global Source Path addition';
  
  // external tools
  lisExtToolFailedToRunTool = 'Failed to run tool';
  lisExtToolUnableToRunTheTool = 'Unable to run the tool %s%s%s:%s%s';
  lisExtToolExternalTools = 'External tools';
  lisExtToolRemove = 'Remove';
  lisKeepThemAndContinue = 'Keep them and continue';
  lisRemoveThem = 'Remove them';
  lisExtToolMoveUp = 'Up';
  lisExtToolMoveDown = 'Down';
  lisExtToolMaximumToolsReached = 'Maximum Tools reached';
  lisExtToolThereIsAMaximumOfTools = 'There is a maximum of %s tools.';
  lisExtToolTitleCompleted = '"%s" completed';
  
  // edit external tools
  lisEdtExtToolEditTool = 'Edit Tool';
  lisEdtExtToolProgramfilename = 'Program Filename:';
  lisEdtExtToolParameters = 'Parameters:';
  lisEdtExtToolWorkingDirectory = 'Working Directory:';
  lisEdtExtToolScanOutputForFreePascalCompilerMessages = 'Scan output for '
    +'Free Pascal Compiler messages';
  lisEdtExtToolScanOutputForMakeMessages = 'Scan output for make messages';
  lisEdtExtToolKey = 'Key';
  lisAlternativeKey = 'Alternative key';
  lisEdtExtToolCtrl = 'Ctrl';
  lisEdtExtToolAlt = 'Alt';
  lisEdtExtToolShift = 'Shift';
  lisEdtExtToolMacros = 'Macros';
  lisWorkingDirectoryForBuilding = 'Working directory for building';
  lisWorkingDirectoryForRun = 'Working directory for run';
  lisConfigureBuild = 'Configure Build %s';
  lisEdtExtToolInsert = 'Insert';
  lisEdtExtToolTitleAndFilenameRequired = 'Title and Filename required';
  lisEdtExtToolAValidToolNeedsAtLeastATitleAndAFilename = 'A valid tool needs '
    +'at least a title and a filename.';
    
  // find in files dialog
  lisFindFileTextToFind = 'Text to find:';
  lisFindFileCaseSensitive = '&Case sensitive';
  lisFindFileWholeWordsOnly = '&Whole words only';
  lisFindFileRegularExpressions = '&Regular expressions';
  lisFindFileMultiLinePattern = '&Multiline pattern';
  lisFindFileWhere = 'Where';
  lisFindFilesearchAllFilesInProject = 'search all files in &project';
  lisFindFilesearchAllOpenFiles = 'search all &open files';
  lisFindFilesearchInDirectories = 'search in &directories';
  lisFindFileDirectoryOptions = 'Directory options';
  lisFindFileFileMaskBak = 'File mask (*;*.*;*.bak?)';
  lisFindFileIncludeSubDirectories = 'Include sub directories';
  lisFindFileOnlyTextFiles = 'Only text files';

  // package manager
  lisPkgMangPackage = 'Package: %s';
  lisPkgMangProject = 'Project: %s';
  lisPkgMangLazarus = 'Lazarus';
  lisPkgMangDependencyWithoutOwner = 'Dependency without Owner: %s';
  lisPkgMangSavePackageLpk = 'Save Package %s (*.lpk)';
  lisPkgMangInvalidPackageFileExtension = 'Invalid package file extension';
  lisPkgMangPackagesMustHaveTheExtensionLpk = 'Packages must have the '
    +'extension .lpk';
  lisPkgMangInvalidPackageName = 'Invalid package name';
  lisPkgMangThePackageNameIsNotAValidPackageNamePleaseChooseAn = 'The package '
    +'name %s%s%s is not a valid package name%sPlease choose another name (e.'
    +'g. package1.lpk)';
  lisPkgMangRenameFileLowercase = 'Rename File lowercase?';
  lisPkgMangShouldTheFileRenamedLowercaseTo = 'Should the file be renamed '
    +'lowercase to%s%s%s%s?';
  lisPkgMangPackageNameAlreadyExists = 'Package name already exists';
  lisNameConflict = 'Name conflict';
  lisThePackageAlreadyContainsAUnitWithThisName = 'The package already '
    +'contains a unit with this name.';
  lisPkgMangThereIsAlreadyAnotherPackageWithTheName = 'There is already '
    +'another package with the name %s%s%s.%sConflict package: %s%s%s%sFile: %'
    +'s%s%s';
  lisPkgMangFilenameIsUsedByProject = 'Filename is used by project';
  lisPkgMangTheFileNameIsPartOfTheCurrentProject = 'The file name %s%s%s is '
    +'part of the current project.%sProjects and Packages should not share '
    +'files.';
  lisPkgMangFilenameIsUsedByOtherPackage = 'Filename is used by other package';
  lisPkgMangTheFileNameIsUsedByThePackageInFile = 'The file name %s%s%s is '
    +'used by%sthe package %s%s%s%sin file %s%s%s.';
  lisPkgMangReplaceFile = 'Replace File';
  lisPkgMangReplaceExistingFile = 'Replace existing file %s%s%s?';
  lisPkgMangDeleteOldPackageFile = 'Delete Old Package File?';
  lisPkgMangDeleteOldPackageFile2 = 'Delete old package file %s%s%s?';
  lisPkgMangDeleteFailed = 'Delete failed';
  lisAmbiguousUnitFound = 'Ambiguous Unit found';
  lisTheFileWasFoundInOneOfTheSourceDirectoriesOfThePac = 'The file %s%s%s%'
    +'swas found in one of the source directories of the package %s and looks '
    +'like a compiled unit. Compiled units must be in the output directory of '
    +'the package, otherwise other packages can get problems using this '
    +'package.%s%sDelete ambiguous file?';
  lisPkgMangUnableToDeleteFile = 'Unable to delete file %s%s%s.';
  lisDeleteAllTheseFiles = 'Delete all these files?';
  lisPkgMangUnsavedPackage = 'Unsaved package';
  lisFpcmakeFailed = 'fpcmake failed';
  lisCallingToCreateMakefileFromFailed = 'Calling %s to create Makefile from %'
    +'s failed.';
  lisPkgMangThereIsAnUnsavedPackageInTheRequiredPackages = 'There is an '
    +'unsaved package in the required packages. See package graph.';
  lisPkgMangBrokenDependency = 'Broken dependency';
  lisPkgMangTheProjectRequiresThePackageButItWasNotFound = 'The project '
    +'requires the package %s%s%s.%sBut it was not found. See Project -> '
    +'Project Inspector.';
  lisPkgMangARequiredPackagesWasNotFound = 'A required packages was not '
    +'found. See package graph.';
  lisPkgMangCircleInPackageDependencies = 'Circle in package dependencies';
  lisPkgMangThereIsACircleInTheRequiredPackages = 'There is a circle in the '
    +'required packages. See package graph.';
  lisPkgMangThereAreTwoUnitsWithTheSameName1From2From = 'There are two units '
    +'with the same name:%s%s1. %s%s%s from %s%s2. %s%s%s from %s%s%s';
  lisPkgMangThereIsAUnitWithTheSameNameAsAPackage1From2 = 'There is a unit '
    +'with the same name as a package:%s%s1. %s%s%s from %s%s2. %s%s%s%s';
  lisPkgMangAmbiguousUnitsFound = 'Ambiguous units found';
  lisPkgMangBothPackagesAreConnectedThisMeansEitherOnePackageU = '%sBoth '
    +'packages are connected. This means, either one package uses the other, '
    +'or they are both used by a third package.';
  lisPkgMangThereIsAFPCUnitWithTheSameNameFrom = 'There is a FPC unit with '
    +'the same name as:%s%s%s%s%s from %s%s%s';
  lisPkgMangThereIsAFPCUnitWithTheSameNameAsAPackage = 'There is a FPC unit '
    +'with the same name as a package:%s%s%s%s%s%s';
  lisPkgMangErrorWritingFile = 'Error writing file';
  lisProjMangUnableToWriteStateFileForProjectError = 'Unable to write state '
    +'file for project %s%sError: %s';
  lisPkgMangUnableToWriteStateFileOfPackageError = 'Unable to write state '
    +'file %s%s%s%sof package %s.%sError: %s';
  lisPkgMangErrorReadingFile = 'Error reading file';
  lisProjMangUnableToReadStateFileOfProjectError = 'Unable to read state '
    +'file %s of project %s%sError: %s';
  lisPkgMangUnableToReadStateFileOfPackageError = 'Unable to read state file %'
    +'s%s%s%sof package %s.%sError: %s';
  lisPkgMangUnableToCreateDirectory = 'Unable to create directory';
  lisUnableToCreateDirectory2 = 'Unable to create directory %s%s%s';
  lisPkgMangUnableToCreateOutputDirectoryForPackage = 'Unable to create '
    +'output directory %s%s%s%sfor package %s.';
  lisPkgMangUnableToDeleteFilename = 'Unable to delete file';
  lisPkgMangUnableToDeleteOldStateFileForPackage = 'Unable to delete old '
    +'state file %s%s%s%sfor package %s.';
  lisPkgMangUnableToCreatePackageSourceDirectoryForPackage = 'Unable to '
    +'create package source directory %s%s%s%sfor package %s.';
  lisPkgMangUnableToLoadPackage = 'Unable to load package';
  lisPkgMangUnableToOpenThePackage = 'Unable to open the package %s%s%s.%'
    +'sThis package was marked for installation.';
  lisPkgMangInvalidPackageName2 = 'Invalid Package Name';
  lisOpenPackage2 = 'Open package %s';
  lisPkgMangThePackageNameOfTheFileIsInvalid = 'The package name %s%s%s of%'
    +'sthe file %s%s%s is invalid.';
  lisLazbuildIsNonInteractiveAbortingNow = '%s%s%s%slazbuild is non '
    +'interactive, aborting now.';
  lisPkgMangPackageConflicts = 'Package conflicts';
  lisPkgMangThereIsAlreadyAPackageLoadedFromFile = 'There is already a '
    +'package %s%s%s loaded%sfrom file %s%s%s.%sSee Components -> Package '
    +'Graph.%sReplace is impossible.';
  lisPkgMangSavePackage = 'Save Package?';
  lisPkgMangLoadingPackageWillReplacePackage = 'Loading package %s will '
    +'replace package %s%sfrom file %s.%sThe old package is modified.%s%sSave '
    +'old package %s?';
  lisPkgMangNewPackage = 'NewPackage';
  lisProbablyYouNeedToInstallSomePackagesForBeforeConti = 'Probably you need '
    +'to install some packages for before continuing.%s%sWarning:%sThe '
    +'project depends on some packages, which contain units with the Register '
    +'procedure. The Register procedure is normally used to install '
    +'components in the IDE. But the following units belong to packages '
    +'which are not yet installed in the IDE. If you try to open a form in '
    +'the IDE, that uses such components, you will get errors about missing '
    +'components and the form loading will probably create very unpleasant '
    +'results.%s%sThis has no impact on opening the project or any of its '
    +'sources.%s%sIt only means: It is a bad idea to open the forms for '
    +'designing, before installing the missing packages.%s%s';
  lisPackageNeedsInstallation = 'Package needs installation';
  lisUnitInPackage = '%s unit %s in package %s%s';
  lisPkgMangSkipThisPackage = 'Skip this package';
  lisPkgMangInvalidFileExtension = 'Invalid file extension';
  lisPkgMangTheFileIsNotALazarusPackage = 'The file %s%s%s is not a lazarus '
    +'package.';
  lisPkgMangInvalidPackageFilename = 'Invalid package filename';
  lisPkgMangThePackageFileNameInIsNotAValidLazarusPackageName = 'The package '
    +'file name %s%s%s in%s%s%s%s is not a valid lazarus package name.';
  lisPkgMangFileNotFound = 'File %s%s%s not found.';
  lisPkgMangErrorReadingPackage = 'Error Reading Package';
  lisPkgUnableToReadPackageFileError = 'Unable to read package file %s%s%s.%'
    +'sError: %s';
  lisPkgMangFilenameDiffersFromPackagename =
    'Filename differs from Packagename';
  lisPkgMangTheFilenameDoesNotCorrespondToThePackage = 'The filename %s%s%s '
    +'does not correspond to the package name %s%s%s in the file.%sChange '
    +'package name to %s%s%s?';
  lisPkgMangSavePackage2 = 'Save package?';
  lisPkgMangPackageFileMissing = 'Package file missing';
  lisPkgMangTheFileOfPackageIsMissing = 'The file %s%s%s%sof package %s is '
    +'missing.';
  lisPkgMangPackageFileNotSaved = 'Package file not saved';
  lisPkgMangTheFileOfPackageNeedsToBeSavedFirst = 'The file %s%s%s%sof '
    +'package %s needs to be saved first.';
  lisPkgMangIgnoreAndSavePackageNow = 'Ignore and save package now';
  lisPkgMangPackageChangedSave = 'Package %s%s%s changed. Save?';
  lisPkgMangErrorWritingPackage = 'Error Writing Package';
  lisPkgMangUnableToWritePackageToFileError = 'Unable to write package %s%s%s%'
    +'sto file %s%s%s.%sError: %s';
  lisSeeProjectProjectInspector = '%sSee Project -> Project Inspector';
  lisPkgMangTheFollowingPackageFailedToLoad = 'The following package failed '
    +'to load:';
  lisPkgMangTheFollowingPackagesFailedToLoad = 'The following packages failed '
    +'to load:';
  lisMissingPackages = 'Missing Packages';
  lisPkgManginvalidCompilerFilename = 'invalid Compiler filename';
  lisPkgMangTheCompilerFileForPackageIsNotAValidExecutable = 'The compiler '
    +'file for package %s is not a valid executable:%s%s';
  lisPkgMangPackageHasNoValidOutputDirectory = 'Package %s%s%s has no valid '
    +'output directory:%s%s%s%s';
  lisPkgMangpackageMainSourceFile = 'package main source file';
  lisPkgMangThisFileWasAutomaticallyCreatedByLazarusDoNotEdit = 'This file '
    +'was automatically created by Lazarus. Do not edit!';
  lisPkgMangThisSourceIsOnlyUsedToCompileAndInstallThePackage = 'This source '
    +'is only used to compile and install the package.';
  lisPkgMangRenameFileInPackage = 'Rename file in package?';
  lisPkgMangThePackageOwnsTheFileShouldTheFileBeRenamed = 'The package %s '
    +'owns the file%s%s%s%s.%sShould the file be renamed in the package as '
    +'well?';
  lisErrorLoadingFile = 'Error loading file';
  lisLoadingFailed = 'Loading %s failed.';
  lisPkgMangAddingNewDependencyForProjectPackage = '%sAdding new Dependency '
    +'for project %s: package %s%s';
  lisPkgMangAddingNewDependencyForPackagePackage = '%sAdding new Dependency '
    +'for package %s: package %s%s';
  lisPkgMangTheFollowingUnitsWillBeAddedToTheUsesSectionOf = '%sThe following '
    +'units will be added to the uses section of%s%s:%s%s%s';
  lisConfirmChanges = 'Confirm changes';
  lisPkgMangFileNotSaved = 'File not saved';
  lisPkgMangPleaseSaveTheFileBeforeAddingItToAPackage = 'Please save the file '
    +'before adding it to a package.';
  lisPkgMangFileIsInProject = 'File is in Project';
  lisPkgMangWarningTheFileBelongsToTheCurrentProject = 'Warning: The file %s%'
    +'s%s%sbelongs to the current project.';
  lisPkgMangFileIsAlreadyInPackage = 'File is already in package';
  lisPkgMangTheFileIsAlreadyInThePackage = 'The file %s%s%s%sis already in '
    +'the package %s.';
  lisPkgMangPackageIsNoDesigntimePackage = 'Package is no designtime package';
  lisPkgMangThePackageIsARuntimeOnlyPackageRuntimeOnlyPackages = 'The package %'
    +'s is a runtime only package.%sRuntime only packages can not be '
    +'installed in the IDE.';
  lisPkgMangAutomaticallyInstalledPackages = 'Automatically installed packages';
  lisPkgMangInstallingThePackageWillAutomaticallyInstallThePac2 = 'Installing '
    +'the package %s will automatically install the packages:';
  lisPkgMangInstallingThePackageWillAutomaticallyInstallThePac = 'Installing '
    +'the package %s will automatically install the package:';
  lisPkgMangRebuildLazarus = 'Rebuild Lazarus?';
  lisPkgMangThePackageWasMarkedForInstallationCurrentlyLazarus = 'The package %'
    +'s%s%s was marked for installation.%sCurrently lazarus only supports '
    +'static linked packages. The real installation needs rebuilding and '
    +'restarting of lazarus.%s%sDo you want to rebuild Lazarus now?';
  lisPkgMangPackageIsRequired = 'Package is required';
  lisPkgMangThePackageIsRequiredByWhichIsMarkedForInstallation = 'The package %'
    +'s is required by %s, which is marked for installation.%sSee package '
    +'graph.';
  lisPkgMangUninstallPackage = 'Uninstall package?';
  lisPkgMangUninstallPackage2 = 'Uninstall package %s?';
  lisPkgMangThePackageWasMarkedCurrentlyLazarus = 'The package %s%s%s was '
    +'marked.%sCurrently lazarus only supports static linked packages. The '
    +'real un-installation needs rebuilding and restarting of lazarus.%s%'
    +'sDo you want to rebuild Lazarus now?';
  lisPkgMangThisIsAVirtualPackageItHasNoSourceYetPleaseSaveThe = 'This is a '
    +'virtual package. It has no source yet. Please save the package first.';
  lisPkgMangPleaseSaveThePackageFirst = 'Please save the package first.';
  lisPkgMangThePackageIsMarkedForInstallationButCanNotBeFound = 'The package %'
    +'s%s%s is marked for installation, but can not be found.%sRemove '
    +'dependency from the installation list of packages?';
  lisPkgMangstaticPackagesConfigFile = 'static packages config file';
  lisPkgMangUnableToCreateTargetDirectoryForLazarus = 'Unable to create '
    +'target directory for lazarus:%s%s%s%s.%sThis directory is needed for '
    +'the new changed lazarus IDE with your custom packages.';

  // package system
  lisPkgSysInvalidUnitname = 'Invalid Unitname: %s';
  lisPkgSysUnitNotFound = 'Unit not found: %s%s%s';
  lisPkgSysUnitWasRemovedFromPackage = 'Unit %s%s%s was removed from package';
  lisPkgSysCanNotRegisterComponentsWithoutUnit = 'Can not register components '
    +'without unit';
  lisPkgSysInvalidComponentClass = 'Invalid component class';
  lisPkgSysComponentClassAlreadyDefined = 'Component Class %s%s%s already '
    +'defined';
  lisPkgSysRegisterUnitWasCalledButNoPackageIsRegistering = 'RegisterUnit was '
    +'called, but no package is registering.';
  lisPkgSysUnitName = '%s%sUnit Name: %s%s%s';
  lisPkgSysFileName = '%s%sFile Name: %s%s%s';
  lisPkgSysRegistrationError = 'Registration Error';
  lisPkgSysTheRTLFreePascalComponentLibraryProvidesTheBase =
      'The RTL - '
    +'The Run-Time Library is the basis of all Free Pascal programs.';
  lisPkgSysTheFCLFreePascalComponentLibraryProvidesTheBase =
      'The FCL - '
    +'FreePascal Component Library provides the base classes for object pascal.';
  lisPkgSysTheLCLLazarusComponentLibraryContainsAllBase = 'The LCL - Lazarus '
    +'Component Library contains all base components for form editing.';
  lisPkgSysSynEditTheEditorComponentUsedByLazarus = 'SynEdit - the editor '
    +'component used by Lazarus. http://sourceforge.net/projects/synedit/';
  lisPkgSysCodeToolsToolsAndFunctionsToParseBrowseAndEditPasc = 'CodeTools - '
    +'tools and functions to parse, browse and edit pascal sources';
  lisPkgSysThisIsTheDefaultPackageUsedOnlyForComponents = 'This is the '
    +'default package. Used only for components without a package. These '
    +'components are outdated.';
  lisPkgSysRegisterProcedureIsNil = 'Register procedure is nil';
  lisPkgSysThisPackageIsInstalledButTheLpkFileWasNotFound = 'This package is '
    +'installed, but the lpk file was not found. All its components are '
    +'deactivated. Please fix this.';
  lisPkgSysPackageFileNotFound = 'Package file not found';
  lisPkgSysThePackageIsInstalledButNoValidPackageFileWasFound = 'The package %'
    +'s%s%s is installed, but no valid package file (.lpk) was found.%sA broken '
    +'dummy package was created.';

  // package defs
  lisPkgDefsOutputDirectory = 'Output directory';
  lisPkgDefsCompiledSrcPathAddition = 'CompiledSrcPath addition';
  lisPkgDefsUnitPath = 'Unit Path';
  lisProjProjectSourceDirectoryMark = 'Project Source Directory Mark';
  lisPkgDefsSrcDirMark = 'Package Source Directory Mark';

  // add active file to package dialog
  lisAF2PInvalidPackage = 'Invalid Package';
  lisAF2PInvalidPackageID = 'Invalid package ID: %s%s%s';
  lisAF2PPackageNotFound = 'Package %s%s%s not found.';
  lisAF2PPackageIsReadOnly = 'Package is read only';
  lisAF2PThePackageIsReadOnly = 'The package %s is read only.';
  lisAF2PTheFileIsAlreadyInThePackage = 'The file %s%s%s%sis already in the '
    +'package %s.';
  lisAF2PUnitName = 'Unit Name: ';
  lisAF2PHasRegisterProcedure = 'Has Register procedure';
  lisAF2PIsVirtualUnit = 'Virtual unit (source is not in package)';
  lisAF2PFileType = 'File Type';
  lisAF2PDestinationPackage = 'Destination Package';
  lisAF2PShowAll = 'Show All';
  lisAF2PAddFileToAPackage = 'Add file to a package';
  
  // add to package dialog
  lisA2PInvalidFilename = 'Invalid filename';
  lisA2PTheFilenameIsAmbiguousPleaseSpecifiyAFilename = 'The filename %s%s%s '
    +'is ambiguous, because the package has no default directory yet.%s'
    +'Please specify a filename with full path.';
  lisA2PFileNotUnit = 'File not unit';
  lisA2PPascalUnitsMustHaveTheExtensionPPOrPas = 'Pascal units must have the '
    +'extension .pp or .pas';
  lisA2PisNotAValidUnitName = '%s%s%s is not a valid unit name.';
  lisA2PUnitnameAlreadyExists = 'Unitname already exists';
  lisA2PTheUnitnameAlreadyExistsInThisPackage = 'The unitname %s%s%s already '
    +'exists in this package.';
  lisA2PTheUnitnameAlreadyExistsInThePackage = 'The unitname %s%s%s already '
    +'exists in the package:%s%s';
  lisA2PAmbiguousUnitName = 'Ambiguous Unit Name';
  lisA2PTheUnitNameIsTheSameAsAnRegisteredComponent = 'The unit name %s%s%s '
    +'is the same as an registered component.%sUsing this can cause strange '
    +'error messages.';
  lisA2PFileAlreadyExistsInTheProject = 'File %s%s%s already exists in the '
    +'project.';
  lisA2PExistingFile = '%sExisting file: %s%s%s';
  lisA2PFileAlreadyExists = 'File already exists';
  lisA2PFileIsUsed = 'File is used';
  lisA2PTheFileIsPartOfTheCurrentProjectItIsABadIdea = 'The file %s%s%s is '
    +'part of the current project.%sIt is a bad idea to share files between '
    +'projects and packages.';
  lisA2PTheMaximumVersionIsLowerThanTheMinimimVersion = 'The Maximum Version '
    +'is lower than the Minimim Version.';
  lisA2PThePackageNameIsInvalidPleaseChooseAnExisting = 'The package name %s%s%'
    +'s is invalid.%sPlease choose an existing package.';
  lisA2PThePackageHasAlreadyADependencyForThe = 'The package has already a '
    +'dependency for the package %s%s%s.';
  lisA2PNoPackageFoundForDependencyPleaseChooseAnExisting = 'No package found '
    +'for dependency %s%s%s.%sPlease choose an existing package.';
  lisA2PInvalidUnitName = 'Invalid Unit Name';
  lisA2PTheUnitNameAndFilenameDiffer = 'The unit name %s%s%s%sand filename %s%'
    +'s%s differ.';
  lisA2PFileAlreadyInPackage = 'File already in package';
  lisA2PTheFileIsAlreadyInThePackage = 'The file %s%s%s is already in the '
    +'package.';
  lisA2PInvalidFile = 'Invalid file';
  lisA2PAPascalUnitMustHaveTheExtensionPPOrPas = 'A pascal unit must have the '
    +'extension .pp or .pas';
  lisA2PInvalidAncestorType = 'Invalid Ancestor Type';
  lisA2PTheAncestorTypeIsNotAValidPascalIdentifier = 'The ancestor type %s%s%'
    +'s is not a valid pascal identifier.';
  lisA2PPageNameTooLong = 'Page Name too long';
  lisA2PThePageNameIsTooLongMax100Chars = 'The page name %s%s%s is too long ('
    +'max 100 chars).';
  lisA2PUnitNameInvalid = 'Unit Name Invalid';
  lisA2PTheUnitNameDoesNotCorrespondToTheFilename = 'The unit name %s%s%s '
    +'does not correspond to the filename.';
  lisA2PInvalidClassName = 'Invalid Class Name';
  lisA2PTheClassNameIsNotAValidPascalIdentifier = 'The class name %s%s%s is '
    +'not a valid pascal identifier.';
  lisA2PInvalidCircle = 'Invalid Circle';
  lisA2PTheClassNameAndAncestorTypeAreTheSame = 'The class name %s%s%s and '
    +'ancestor type %s%s%s are the same.';
  lisA2PAmbiguousAncestorType = 'Ambiguous Ancestor Type';
  lisA2PTheAncestorTypeHasTheSameNameAsTheUnit = 'The ancestor type %s%s%s '
    +'has the same name as%sthe unit %s%s%s.';
  lisA2PAmbiguousClassName = 'Ambiguous Class Name';
  lisA2PTheClassNameHasTheSameNameAsTheUnit = 'The class name %s%s%s has the '
    +'same name as%sthe unit %s%s%s.';
  lisA2PClassNameAlreadyExists = 'Class Name already exists';
  lisA2PTheClassNameExistsAlreadyInPackageFile = 'The class name %s%s%s '
    +'exists already in%sPackage %s%sFile: %s%s%s';
  lisA2PTheMinimumVersionIsInvalidPleaseUseTheFormatMajor = 'The Minimum '
    +'Version %s%s%s is invalid.%sPlease use the format major.minor.release.'
    +'build%sFor exmaple: 1.0.20.10';
  lisA2PTheMaximumVersionIsInvalidPleaseUseTheFormatMajor = 'The Maximum '
    +'Version %s%s%s is invalid.%sPlease use the format major.minor.release.'
    +'build%sFor exmaple: 1.0.20.10';
  lisA2PAddUnit = 'Add Unit';
  lisA2PNewFile = 'New File';
  lisA2PNewComponent = 'New Component';
  lisA2PAddFile = 'Add File';
  lisA2PAddFiles = 'Add Files';
  lisA2PUnitFileName = 'Unit file name:';
  lisA2PchooseAnExistingFile = '<choose an existing file>';
  lisA2PAddLFMLRSFilesIfTheyExist = 'Add LFM, LRS files, if they exist';
  lisA2PUpdateUnitNameAndHasRegisterProcedure = 'Scan Unit for Unit Name and '
    +'Register procedure';
  lisA2PAncestorType = 'Ancestor Type';
  lisA2PShowAll = 'Show all';
  lisA2PNewClassName = 'New class name:';
  lisA2PPalettePage = 'Palette Page:';
  lisA2PUnitFileName2 = 'Unit File Name:';
  lisA2PUnitName = 'Unit Name:';
  lisA2PShortenOrExpandFilename = 'Shorten or expand filename';
  lisA2PSaveFileDialog = 'Save file dialog';
  lisA2PFileName = 'File name:';
  
  // broken dependencies dialog
  lisBDDChangingThePackageNameOrVersionBreaksDependencies = 'Changing the '
    +'package name or version breaks dependencies. Should these dependencies '
    +'be changed as well?%sSelect Yes to change all listed dependencies.%'
    +'sSelect Ignore to break the dependencies and continue.';
  lisA2PDependency = 'Dependency';
  lisA2PBrokenDependencies = 'Broken Dependencies';
  
  // open installed packages dialog
  lisOIPFilename = 'Filename:  %s';
  lisOIPThisPackageWasAutomaticallyCreated = '%sThis package was '
    +'automatically created';
  lisOIPThisPackageIsInstalledButTheLpkFileWasNotFound = '%sThis package is '
    +'installed, but the lpk file was not found';
  lisOIPDescriptionDescription = '%sDescription:  %s';
  lisOIPDescription = 'Description:  ';
  lisOIPPleaseSelectAPackage = 'Please select a package';
  lisOIPNoPackageSelected = 'No package selected';
  lisOIPPleaseSelectAPackageToOpen = 'Please select a package to open';
  lisOIPPackageName = 'Package Name';
  lisOIPState = 'State';
  lisOIPmodified = 'modified';
  lisOIPmissing = 'missing';
  lisOIPinstalledStatic = 'installed static';
  lisOIPinstalledDynamic = 'installed dynamic';
  lisOIPautoInstallStatic = 'auto install static';
  lisOIPautoInstallDynamic = 'auto install dynamic';
  lisOIPreadonly = 'readonly';
  lisOIPOpenLoadedPackage = 'Open loaded package';
  
  // package editor
  lisPckEditRemoveFile = 'Remove file';
  lisPEMoveFileUp = 'Move file up';
  lisPEMoveFileDown = 'Move file down';
  lisPckEditReAddFile = 'Re-Add file';
  lisPESortFiles = 'Sort files';
  lisPEFixFilesCase = 'Fix Files Case';
  lisPckEditRemoveDependency = 'Remove dependency';
  lisPckEditMoveDependencyUp = 'Move dependency up';
  lisPckEditMoveDependencyDown = 'Move dependency down';
  lisPckEditReAddDependency = 'Re-Add dependency';
  lisPckEditSetDependencyDefaultFilename = 'Store dependency filename';
  lisPckEditClearDependencyDefaultFilename = 'Clear dependency filename';
  lisPckEditCompile = 'Compile';
  lisPckEditRecompileClean = 'Recompile clean';
  lisPckEditRecompileAllRequired = 'Recompile all required';
  lisPckEditCreateMakefile = 'Create Makefile';
  lisPckEditAddToProject = 'Add to project';
  lisPckEditInstall = 'Install';
  lisPckEditUninstall = 'Uninstall';
  lisPckEditViewPackgeSource = 'View Package Source';
  lisPEViewToDoList = 'View ToDo list';
  lisPckEditGeneralOptions = 'General Options';
  lisPckEditSaveChanges = 'Save Changes?';
  lisPckEditPackageHasChangedSavePackage = 'Package %s%s%s has changed.%sSave '
    +'package?';
  lisPckEditPage = '%s, Page: %s';
  lisPckEditRemoveFile2 = 'Remove file?';
  lisPckEditRemoveFileFromPackage = 'Remove file %s%s%s%sfrom package %s%s%s?';
  lisPckEditRemoveDependency2 = 'Remove Dependency?';
  lisPckEditRemoveDependencyFromPackage = 'Remove dependency %s%s%s%sfrom '
    +'package %s%s%s?';
  lisPckEditInvalidMinimumVersion = 'Invalid minimum version';
  lisPckEditTheMinimumVersionIsNotAValidPackageVersion = 'The minimum '
    +'version %s%s%s is not a valid package version.%s(good example 1.2.3.4)';
  lisPckEditInvalidMaximumVersion = 'Invalid maximum version';
  lisPckEditTheMaximumVersionIsNotAValidPackageVersion = 'The maximum '
    +'version %s%s%s is not a valid package version.%s(good example 1.2.3.4)';
  lisPckEditCompileEverything = 'Compile everything?';
  lisPckEditReCompileThisAndAllRequiredPackages = 'Re-Compile this and all '
    +'required packages?';
  lisPckEditCompilerOptionsForPackage = 'Compiler Options for Package %s';
  lisPckEditSavePackage = 'Save package';
  lisPckEditCompilePackage = 'Compile package';
  lisPckEditAddAnItem = 'Add an item';
  lisPckEditRemoveSelectedItem = 'Remove selected item';
  lisPckEditInstallPackageInTheIDE = 'Install package in the IDE';
  lisPckEditEditGeneralOptions = 'Edit General Options';
  lisPckEditCompOpts = 'Compiler Options';
  lisPckEditHelp = 'Help';
  lisPkgEdThereAreMoreFunctionsInThePopupmenu = 'There are more functions in '
    +'the popupmenu';
  lisPckEditMore = 'More ...';
  lisPckEditEditOptionsToCompilePackage = 'Edit Options to compile package';
  lisPckEditRequiredPackages = 'Required Packages';
  lisPckEditFileProperties = 'File Properties';
  lisPckEditRegisterUnit = 'Register unit';
  lisPckEditCallRegisterProcedureOfSelectedUnit = 'Call %sRegister%s '
    +'procedure of selected unit';
  lisPckEditRegisteredPlugins = 'Registered plugins';
  lisPkgMangAddUnitToUsesClauseOfPackageDisableThisOnlyForUnit = 'Add unit to '
    +'uses clause of package. Disable this only for units, that should not be '
    +'compiled in all cases.';
  lisPkgMangUseUnit = 'Use unit';
  lisPckEditMinimumVersion = 'Minimum Version:';
  lisPckEditMaximumVersion = 'Maximum Version:';
  lisPckEditApplyChanges = 'Apply changes';
  lisPckEditPackage = 'Package %s';
  lisPckEditRemovedFilesTheseEntriesAreNotSavedToTheLpkFile = 'Removed Files ('
    +'these entries are not saved to the lpk file)';
  lisPckEditRemovedRequiredPackagesTheseEntriesAreNotSaved = 'Removed '
    +'required packages (these entries are not saved to the lpk file)';
  lisPckEditDependencyProperties = 'Dependency Properties';
  lisPckEditpackageNotSaved = 'package %s not saved';
  lisPckEditReadOnly = 'Read Only: %s';
  lisPckEditModified = 'Modified: %s';
  lisPkgEditNewUnitNotInUnitpath = 'New unit not in unitpath';
  lisPkgEditTheFileIsCurrentlyNotInTheUnitpathOfThePackage = 'The file %s%s%s%'
    +'sis currently not in the unitpath of the package.%s%sAdd %s%s%s to '
    +'UnitPath?';
  lisPkgEditRevertPackage = 'Revert package?';
  lisPkgEditDoYouReallyWantToForgetAllChangesToPackageAnd = 'Do you really '
    +'want to forget all changes to package %s and reload it from file?';

  // package options dialog
  lisPckOptsUsage = 'Usage';
  lisPOChoosePoFileDirectory = 'Choose .po file directory';
  lisPckOptsIDEIntegration = 'IDE Integration';
  lisPckOptsProvides = 'Provides';
  lisPckOptsDescriptionAbstract = 'Description/Abstract';
  lisPckOptsAuthor = 'Author:';
  lisPckOptsLicense = 'License:';
  lisPckOptsMajor = 'Major';
  lisPckOptsMinor = 'Minor';
  lisPckOptsRelease = 'Release';
  lisBuildNumber = 'Build Number';
  lisPckOptsAutomaticallyIncrementVersionOnBuild = 'Automatically increment '
    +'version on build';
  lisPckOptsPackageType = 'PackageType';
  lisPckOptsDesigntimeOnly = 'Designtime only';
  lisPckOptsRuntimeOnly = 'Runtime only';
  lisPckOptsDesigntimeAndRuntime = 'Designtime and Runtime';
  lisPckOptsUpdateRebuild = 'Update/Rebuild';
  lisPckOptsAutomaticallyRebuildAsNeeded = 'Automatically rebuild as needed';
  lisPckOptsAutoRebuildWhenRebuildingAll = 'Auto rebuild when rebuilding all';
  lisPckOptsManualCompilationNeverAutomatically = 'Manual compilation (never '
    +'automatically)';
  lisPckOptsLazDocLazarusDocumentation = 'FPDoc files path';
  lisPckOptsAddPathsToDependentPackagesProjects = 'Add paths to dependent '
    +'packages/projects';
  lisPckOptsInclude = 'Include';
  lisPckOptsObject = 'Object';
  lisPckOptsLibrary = 'Library';
  lisPckOptsAddOptionsToDependentPackagesAndProjects = 'Add options to '
    +'dependent packages and projects';
  lisPckOptsLinker = 'Linker';
  lisPckOptsCustom = 'Custom';
  lisPckOptsInvalidPackageType = 'Invalid package type';
  lisPckOptsThePackageHasTheAutoInstallFlagThisMeans = 'The package %s%s%s '
    +'has the auto install flag.%sThis means it will be installed in the IDE. '
    +'Installation packages%smust be designtime Packages.';
  lisPckOptsPackageOptions = 'Package Options';

  // package explorer (package graph)
  lisPckExplLoadedPackages = 'Loaded Packages:';
  lisPckExplIsRequiredBy = 'Selected package is required by:';
  lisPckExplPackageNotFound = 'Package %s not found';
  lisPckExplState = '%sState: ';
  lisPckExplAutoCreated = 'AutoCreated';
  lisPckExplInstalled = 'Installed';
  lisPckExplInstallOnNextStart = 'Install on next start';
  lisPckExplUninstallOnNextStart = 'Uninstall on next start';
  
  // project inspector
  lisProjInspConfirmDeletingDependency = 'Confirm deleting dependency';
  lisProjInspConfirmRemovingFile = 'Confirm removing file';
  lisProjInspDeleteDependencyFor = 'Delete dependency for %s?';
  lisProjInspRemoveFileFromProject = 'Remove file %s from project?';
  lisProjInspRemovedRequiredPackages = 'Removed required packages';
  lisProjInspProjectInspector = 'Project Inspector - %s';
  
  // Find palette component dialog
  lisFPFindPaletteComponent = 'Find palette component';
  lisFPComponents = 'Components';
  
  // components list form
  lisCmpLstComponents = 'Components';
  lisCmpLstList = 'List';
  lisCmpLstPalette = 'Palette';
  lisCmpLstInheritance = 'Inheritance';

  // menu editor
  lisMenuEditorMenuEditor = 'Menu Editor';
  lisMenuEditorSelectMenu = 'Select Menu:';
  lisMenuEditorSelectTemplate = 'Select Template:';
  lisMenuEditorTemplatePreview = 'Template Preview';
  lisMenuEditorNewTemplateDescription = 'New Template Description...';
  lisMenuEditorCancel = 'Cancel';
  lisMenuEditorInsertNewItemAfter = 'Insert New Item (after)';
  lisMenuEditorInsertNewItemBefore = 'Insert New Item (before)';
  lisMenuEditorDeleteItem = 'Delete Item';
  lisMenuEditorCreateSubMenu = 'Create Submenu';
  lisMenuEditorHandleOnClickEvent = 'Handle OnClick Event';
  lisMenuEditorMoveUp = 'Move Up (or left)';
  lisMenuEditorMoveDown = 'Move Down (or right)';
  lisMenuEditorInsertFromTemplate = 'Insert From Template...';
  lisMenuEditorSaveAsTemplate = 'Save As Template...';
  lisMenuEditorDeleteFromTemplate = 'Delete From Template...';

  // Standard File menu
  lisMenuTemplateDescriptionStandardFileMenu = 'Standard File Menu';
  lisMenuTemplateFile = 'File';
  lisMenuTemplateNew = 'New';
  lisKMNewUnit = 'New Unit';
  lisMenuTemplateOpen = 'Open';
  lisMenuTemplateOpenRecent = 'Open Recent';
  lisMenuTemplateSave = 'Save';
  lisMenuTemplateSaveAs = 'Save As';
  lisMenuTemplateClose = 'Close';
  lisMenuTemplateExit = 'Exit';

  // Standard Edit menu
  lisMenuTemplateDescriptionStandardEditMenu = 'Standard Edit Menu';
  lisMenuTemplateEdit = 'Edit';
  lisMenuTemplateUndo = 'Undo';
  lisMenuTemplateRedo = 'Redo';
  lisMenuTemplateCut = 'Cut';
  lisMenuTemplateCopy = 'Copy';
  lisMenuTemplatePaste = 'Paste';
  lisMenuTemplateFind = 'Find';
  lisMenuTemplateFindNext = 'Find Next';

  // Standard Help menu
  lisMenuTemplateDescriptionStandardHelpMenu = 'Standard Help Menu';
  lisMenuTemplateHelp = 'Help';
  lisMenuTemplateContents = 'Contents';
  lisMenuTemplateTutorial = 'Tutorial';
  lisMenuTemplateAbout = 'About';
  lisContributors = 'Contributors';
  lisAcknowledgements = 'Acknowledgements';
  lisAboutOfficial = 'Official:';
  lisAboutDocumentation = 'Documentation:';

  // character map
  lisCharacterMap = 'Character Map';
  
  // codetools defines value dialog
  lisCTDefChooseDirectory = 'Choose Directory';
  lisCTDefCodeToolsDirectoryValues = 'CodeTools Directory Values';
  lisCTDefVariable = 'Variable: %s';
  lisCTDefnoVariableSelected = '<no variable selected>';
  lisCTDefVariableName = 'Variable Name';

  // clean directory dialog
  lisClDirCleanSubDirectories = 'Clean sub directories';
  lisClDirRemoveFilesMatchingFilter = 'Remove files matching filter';
  lisClDirSimpleSyntaxEGInsteadOf = 'Simple Syntax (e.g. * instead of .*)';
  lisClDirKeepAllTextFiles = 'Keep all text files';
  lisClDirKeepFilesMatchingFilter = 'Keep files matching filter';
  lisClDirCleanDirectory = 'Clean Directory';
  
  // LFM repair wizard
  lisTheLFMLazarusFormFileContainsInvalidPropertiesThis = 'The LFM (Lazarus '
    +'form) file contains invalid properties. This means for example it '
    +'contains some properties/classes, which do not exist in the current '
    +'LCL. The normal fix is to remove these properties from the lfm and fix '
    +'the pascal code manually.';
  lisFixLFMFile = 'Fix LFM file';
  lisMissingEvents = 'Missing Events';
  lisTheFollowingMethodsUsedByAreNotInTheSourceRemoveTh = 'The following '
    +'methods used by %s are not in the source%s%s%s%s%s%sRemove the dangling '
    +'references?';

  // extract proc dialog
  lisNoCodeSelected = 'No code selected';
  lisPleaseSelectSomeCodeToExtractANewProcedureMethod = 'Please select some '
    +'code to extract a new procedure/method.';
  lisInvalidSelection = 'Invalid selection';
  lisThisStatementCanNotBeExtractedPleaseSelectSomeCode = 'This statement can '
    +'not be extracted.%sPlease select some code to extract a new procedure/'
    +'method.';
  lisExtractProcedure = 'Extract Procedure';
  lisNameOfNewProcedure = 'Name of new procedure';
  lisExtract = 'Extract';
  lisInvalidProcName = 'Invalid proc name';
  lisPublicMethod = 'Public Method';
  lisPrivateMethod = 'Private Method';
  lisProtectedMethod = 'Protected Method';
  lisPublishedMethod = 'Published Method';
  lisProcedure = 'Procedure';
  lisProcedureWithInterface = 'Procedure with interface';
  lisSubProcedure = 'Sub Procedure';
  lisSubProcedureOnSameLevel = 'Sub Procedure on same level';
  lisFreePascalCompilerNotFound = 'Free Pascal Compiler not found';
  lisTheFreePascalCompilerFilenameWasNotFoundItIsRecomm = 'The Free Pascal '
    +'compiler (filename: %s) was not found.%sIt is recommended that you '
    +'install fpc.';
  lisInvalidCompilerFilename = 'Invalid Compiler Filename';
  lisTheCurrentCompilerFilenameIsNotAValidExecutablePlease = 'The current '
    +'compiler filename %s%s%s%sis not a valid executable.%sPlease check '
    +'Environment -> Environment Options -> Files';
  lisFreePascalSourcesNotFound = 'Free Pascal Sources not found';
  lisTheFreePascalSourceDirectoryWasNotFoundSomeCodeFun = 'The Free Pascal '
    +'source directory was not found.%sSome code functions will not work.%sIt '
    +'is recommended that you install it and set the path%sEnvironment -> '
    +'Environment Options -> Files';
  lisInvalidFreePascalSourceDirectory = 'Invalid Free Pascal source directory';
  lisTheCurrentFreePascalSourceDirectoryDoesNotLookCorr2 = 'The current Free '
    +'Pascal source directory %s%s%s%sdoes not look correct.%sCheck '
    +'Environment -> Environment Options -> Files';
  lisLazarusDirectoryNotFound = 'Lazarus directory not found';
  lisTheCurrentLazarusDirectoryDoesNotLookCorrectWithou2 = 'The current '
    +'Lazarus directory %s%s%s%sdoes not look correct.%sWithout it You will '
    +'not be able to create LCL applications.%sCheck Environment -> '
    +'Environment Options -> Files';
  lisTheCurrentLazarusDirectoryDoesNotLookCorrectWithou = 'The current '
    +'Lazarus directory %s%s%s%sdoes not look correct.%sWithout it You will '
    +'not be able to create LCL applications.%sChoose Ok to choose the '
    +'default %s%s%s.%sOtherwise check Environment -> Environment Options -> '
    +'Files';
  lisTheLazarusDirectoryWasNotFoundYouWillNotBeAbleToCr = 'The Lazarus '
    +'directory was not found.%sYou will not be able to create LCL '
    +'applications.%sPlease check Environment -> Environment Options -> Files';
  lisTheCurrentFreePascalSourceDirectoryDoesNotLookCorr = 'The current Free '
    +'Pascal source directory %s%s%s%sdoes not look correct.%sChoose Ok to '
    +'choose the default %s%s%s.%sOtherwise check Environment -> Environment '
    +'Options -> Files';
  lisTheCurrentCompilerFilenameIsNotAValidExecutableCho = 'The current '
    +'compiler filename %s%s%s%sis not a valid executable.%sChoose Ok to '
    +'choose the default %s%s%s.%sOtherwise check Environment -> Environment '
    +'Options -> Files';
    
  // Help Options
  lisHlpOptsHelpOptions = 'Help Options';
  lisHlpOptsViewers = 'Viewers';
  lisHOFPCDocHTMLPath = 'FPC Doc HTML Path';
  lisHlpOptsProperties = 'Properties:';
  lisHlpOptsDatabases = 'Databases';

  // enclose selection dialog
  lisEncloseSelection = 'Enclose Selection';
  lisEnclose = 'Enclose';
  lisChooseStructureToEncloseSelection =
    'Choose structure to enclose selection';
    
  lisErrors = 'Errors';
  lisLFMFile = 'LFM file';
  lisRemoveAllInvalidProperties = 'Remove all invalid properties';
  lisCompTest = '&Test';

  lisA2PSwitchPaths = 'Switch Paths';
  lisA2PAddFilesToPackage = 'Add files to package';
  lisA2PAddToPackage = 'Add to package';
  lisA2PFilename2 = 'Filename';
  lisFRIFindOrRenameIdentifier = 'Find or Rename Identifier';
  lisHelpSelectorDialog = 'Help selector';
  lisSelectAHelpItem = 'Select a help item:';
  lisErrorMovingComponent = 'Error moving component';
  lisErrorMovingComponent2 = 'Error moving component %s:%s';
  lisInstalledPackages = 'Installed Packages';
  lisAvailablePackages = 'Available packages';
  lisExportList = 'Export list';
  lisImportList = 'Import list';
  lisUninstallSelection = 'Uninstall selection';
  lisPackagesToInstallInTheIDE = 'Packages to install in the IDE';
  lisInstallSelection = 'Install selection';
  lisPackageInfo = 'Package Info';
  lisSaveAndRebuildIDE = 'Save and rebuild IDE';
  lisSaveAndExitDialog = 'Save and exit dialog';
  lisAlignment = 'Alignment';
  lisHorizontal = 'Horizontal';
  lisNoChange = 'No change';
  lisTops = 'Tops';
  lisLeftSides = 'Left sides';
  lisCenters = 'Centers';
  lisBottoms = 'Bottoms';
  lisRightSides = 'Right sides';
  lisCenterInWindow = 'Center in window';
  lisSpaceEqually = 'Space equally';
  lisTopSpaceEqually = 'Top space equally';
  lisBottomSpaceEqually = 'Bottom space equally';
  lisLeftSpaceEqually = 'Left space equally';
  lisRightSpaceEqually = 'Right space equally';
  lisVertical = 'Vertical';
  lisScalingFactor = 'Scaling factor:';
  lisCustomProgram = 'Custom Program';
  lisProgram = 'Program';
  lisConsoleApplication = 'Console application';
  lisFreepascalProgramUsingTCustomApplicationToEasilyCh =
      'freepascal program '
    +'using TCustomApplication to easily check command line options, handling '
    +'exceptions, etc. The program file is automatically maintained by lazarus.';
  lisProgramAFreepascalProgramTheProgramFileIsAutomatic = 'Program%sA '
    +'freepascal program. The program file is automatically maintained by '
    +'lazarus.';
  lisCustomProgramAFreepascalProgram = 'Custom Program%sA freepascal program.';
  lisLibraryAFreepascalLibraryDllUnderWindowsSoUnderLin = 'Library%sA '
    +'freepascal library (.dll under windows, .so under linux, .dylib under '
    +'macosx). The library source file is automatically maintained by Lazarus.';
  lisNPSelectAProjectType = 'Select a project type';
  lisNPCreateANewProject = 'Create a new project';
  lisNPCreate = 'Create';
  lisOIFChooseABaseClassForTheFavouriteProperty = 'Choose a base class for '
    +'the favourite property %s%s%s.';
  lisOIFAddToFavouriteProperties = 'Add to favourite properties';
  lisOIFRemoveFromFavouriteProperties = 'Remove from favourite properties';
  lisReplacingSelectionFailed = 'Replacing selection failed.';
  lisUnableToFindInLFMStream = 'Unable to find %s in LFM Stream.';
  lisErrorParsingLfmComponentStream = 'Error parsing lfm component stream.';
  lisUnableToCreateTemporaryLfmBuffer =
    'Unable to create temporary lfm buffer.';
  lisUnableToGetSourceForDesigner = 'Unable to get source for designer.';
  lisUnableToGatherEditorChanges = 'Unable to gather editor changes.';
  lisUnableToStreamSelectedComponents2 =
    'Unable to stream selected components.';
  lisUnableToChangeClassOfTo = '%s%sUnable to change class of %s to %s';
  lisCanOnlyChangeTheClassOfTComponents = 'Can only change the class of '
    +'TComponents.';
  lisOldClass = 'Old Class';
  lisNewClass = 'New Class';
  lisOldAncestors = 'Old Ancestors';
  lisNewAncestors = 'New Ancestors';
  lisCEModeShowCategories = 'Show Categories';
  lisCEModeShowSourceNodes = 'Show Source Nodes';
  lisCEIn = '%s in %s';
  lisCEOUpdate = 'Update';
  lisCEORefreshAutomatically = 'Refresh automatically';
  lisCEONeverOnlyManually = 'Never, only manually';
  lisCEOWhenSwitchingFile = 'When switching file in source editor';
  lisCEOOnIdle = 'On idle';
  lisCEFollowCursor = 'Follow cursor';
  lisCECategories = 'Categories';
  lisCEUses = 'Uses';
  lisCEOnlyUsedInCategoryMode = 'Only used in category mode';
  lisCETypes = 'Types';
  lisCEVariables = 'Variables';
  lisCEConstants = 'Constants';
  lisCEProcedures = 'Procedures';
  lisCEProperties = 'Properties';
  lisCodeObserver = 'Code Observer';
  dlgCOMoveLevelDown = 'Move level down';
  dlgCOMoveLevelUp = 'Move level up';
  dlgCOMoveDown = 'Move down';
  dlgCOMoveUp = 'Move up';
  lisCEOMode = 'Preferred Exhibition Mode';
  lisCEOModeCategory = 'Category';
  lisCEOModeSource = 'Source';

  lisMenuFPDocEditor = 'FPDoc Editor';
  lisCodeHelpMainFormCaption = 'FPDoc editor';
  lisCodeHelpNoTagCaption = '<NONE>';
  lisCodeHelpnoinheriteddescriptionfound = '(no inherited description found)';
  lisCodeHelpShortdescriptionOf = 'Short description of';
  lisCodeHelpNoDocumentation = '(none)';
  lisCodeHelpInherited = 'Inherited';
  lisCodeHelpShortTag = 'Short';
  lisCodeHelpDescrTag = 'Description';
  lisCodeHelpErrorsTag = 'Errors';
  lisCodeHelpSeeAlsoTag = 'See also';
  lisCodeHelpAddPathButton = 'Add path';
  lisCodeHelpDeletePathButton = 'Remove path';
  lisEONOTEOnlyAbsolutePathsAreSupportedNow = 'NOTE: only absolute paths are '
    +'supported now';
  lisCodeHelpConfirmreplace = 'Confirm replace';
  lisCodeHelpReplaceButton = 'Replace';
  lisCodeHelpPathsGroupBox = 'FPDoc files path';
  lisCodeHelpHintBoldFormat = 'Insert bold formatting tag';
  lisCodeHelpHintItalicFormat = 'Insert italic formatting tag';
  lisCodeHelpHintUnderlineFormat = 'Insert underline formatting tag';
  lisCodeHelpHintInsertCodeTag = 'Insert code formatting tag';
  lisCodeHelpHintRemarkTag = 'Insert remark formatting tag';
  lisCodeHelpHintVarTag = 'Insert var formatting tag';
  lisCodeHelpAddLinkButton = 'Add link';
  lisCodeHelpDeleteLinkButton = 'Delete link';
  lisCodeHelpCreateButton = 'Create help item';
  lisCodeHelpInsertALink = 'Insert a link ...';
  lisCodeHelpInsertParagraphFormattingTag = 'Insert paragraph formatting tag';
  lisCodeHelpSaveButton = 'Save';
  lisCodeHelpExampleTag = 'Example';
  lisCodeHelpBrowseExampleButton = 'Browse';
  lisLDMoveEntriesToInherited = 'Move entries to inherited';
  lisLDCopyFromInherited = 'Copy from inherited';
  lisLDAddLinkToInherited = 'Add link to inherited';
  lisEnableMacros = 'Enable Macros';
  lisCTSelectCodeMacro = 'Select Code Macro';
  lisPDProgress = 'Progress';
  lisPDAbort = 'Abort';
  lisPOSaveInLpiFil = 'Save in .lpi file';
  lisPOSaveInLpsFileInProjectDirectory = 'Save in .lps file in project '
    +'directory';
  lisPOSaveInIDEConfigDirectory = 'Save in IDE config directory';
  lisPODoNotSaveAnySessionInfo = 'Do not save any session info';
  lisPOSaveSessionInformationIn = 'Save session information in';
  lisMVSaveMessagesToFileTxt = 'Save messages to file (*.txt)';
  lisShowOldTabOrder = 'Show old tab order';
  lisTabOrderOf = 'Tab Order of';

  lisAnchorEnabledHint = 'Enabled = Include %s in Anchors';
  lisAroundBorderSpaceHint = 'Borderspace around the control. The other four borderspaces are added to this value.';
  lisTopBorderSpaceSpinEditHint = 'Top borderspace. This value is added to base borderspace and used for the space above the control.';
  lisBottomBorderSpaceSpinEditHint = 'Bottom borderspace. This value is added to base borderspace and used for the space below the control.';
  lisLeftBorderSpaceSpinEditHint = 'Left borderspace. This value is added to base borderspace and used for the space left to the control.';
  lisRightBorderSpaceSpinEditHint = 'Right borderspace. This value is added to base borderspace and used for the space right to the control.';
  lisCenterControlVerticallyRelativeToSibling = 'Center control vertically relative to the given sibling';
  lisCenterControlHorizontallyRelativeToSibling = 'Center control horizontally relative to the given sibling';
  lisAnchorToTopSideKeepBorderSpace = 'Anchor to top side of sibling, keep border space';
  lisAnchorToBottomSideKeepBorderSpace = 'Anchor to bottom side of sibling, keep border space';
  lisAnchorToLeftSideKeepBorderSpace = 'Anchor to left side of sibling, keep border space';
  lisAnchorToRightSideKeepBorderSpace = 'Anchor to right side of sibling, keep border space';
  lisTopSiblingComboBoxHint = 'This is the sibling control to which the top side is anchored. Leave empty for parent.';
  lisBottomSiblingComboBoxHint = 'This is the sibling control to which the bottom side is anchored. Leave empty for parent.';
  lisRightSiblingComboBoxHint = 'This is the sibling control to which the right side is anchored. Leave empty for parent.';
  lisLeftSiblingComboBoxHint = 'This is the sibling control to which the left side is anchored. Leave empty for parent.';
  lisBorderSpace = 'BorderSpace';
  lisSibling = 'Sibling';
  lisEnabled = 'Enabled';
  lisRightAnchoring = 'Right anchoring';
  lisTopAnchoring = 'Top anchoring';
  lisLeftGroupBoxCaption = 'Left anchoring';
  lisBottomGroupBoxCaption = 'Bottom anchoring';
  lisUnableToSetAnchorSideControl = 'Unable to set AnchorSide Control';
  lisAnchorEditorNoControlSelected = 'Anchor Editor - no control selected';
  lisAnchorsOfSelectedControls = 'Anchors of selected controls';
  lisDebugOptionsFrmAdditionalSearchPath = 'Additional search path';
  lisDebugOptionsFrmDebuggerGeneralOptions = 'Debugger general options';
  lisDebugOptionsFrmShowMessageOnStop = 'Show message on stop';
  lisDebugOptionsFrmDebuggerSpecific = 'Debugger specific options (depends on '
    +'type of debugger)';
  lisDebugOptionsFrmEventLog = 'Event Log';
  lisDebugOptionsFrmClearLogOnRun = 'Clear log on run';
  lisDebugOptionsFrmLimitLinecountTo = 'Limit linecount to';
  lisDebugOptionsFrmBreakpoint = 'Breakpoint';
  lisDebugOptionsFrmProcess = 'Process';
  lisDebugOptionsFrmThread = 'Thread';
  lisDebugOptionsFrmModule = 'Module';
  lisDebugOptionsFrmOutput = 'Output';
  lisDebugOptionsFrmWindow = 'Window';
  lisDebugOptionsFrmInterface = 'Interface';
  lisDebugOptionsFrmLanguageExceptions = 'Language Exceptions';
  lisDebugOptionsFrmIgnoreTheseExceptions = 'Ignore these exceptions';
  lisDebugOptionsFrmNotifyOnLazarusExceptions = 'Notify on Lazarus Exceptions';
  lisDebugOptionsFrmOSExceptions = 'OS Exceptions';
  lisDebugOptionsFrmSignals = 'Signals';
  lisDebugOptionsFrmName = 'Name';
  lisDebugOptionsFrmID = 'ID';
  lisDebugOptionsFrmHandledBy = 'Handled by';
  lisDebugOptionsFrmResume = 'Resume';
  lisDebugOptionsFrmHandledByProgram = 'Handled by Program';
  lisDebugOptionsFrmHandledByDebugger = 'Handled by Debugger';
  lisDebugOptionsFrmResumeHandled = 'Resume Handled';
  lisDebugOptionsFrmResumeUnhandled = 'Resume Unhandled';
  lisDebugOptionsFrmAddException = 'Add Exception';
  lisDebugOptionsFrmEnterExceptionName = 'Enter the name of the exception';
  lisDebugOptionsFrmDuplicateExceptionName = 'Duplicate Exception name';
  dlgDebugOptionsPathEditorDlgCaption = 'Path Editor';
  lisHFMHelpForFreePascalCompilerMessage = 'Help for FreePascal Compiler '
    +'message';
  lisRelativePaths = 'Relative paths';
  lisLazBuildSaveSettings = 'Save settings';
  rsFormDataFileDfm = 'Form data file (*.dfm)|*.dfm';
  liswlWatchList = 'Watch list';
  liswlExpression = 'Expression';
  lisKMChooseKeymappingScheme = 'Choose Keymapping scheme';
  lisKMNoteAllKeysWillBeSetToTheValuesOfTheChosenScheme = 'Note: All keys '
    +'will be set to the values of the chosen scheme.';
  lisKMKeymappingScheme = 'Keymapping Scheme';
  lisIFDOK = 'OK';
  lisPVUEditVirtualUnit = 'Edit virtual unit';

  // version info tab
  VersionInfoTitle = 'Version Info';
  
  // Procedure List dialog
  lisPListObjects               = '&Objects';
  lisPListJumpToSelection       = 'Jump To Selection';
  lisPListFilterAny             = 'Filter by matching any part of method';
  lisPListFilterStart           = 'Filter by matching with start of method';
  lisPListChangeFont            = 'Change Font';
  lisPListCopyMethodToClipboard = 'Copy method name to the clipboard';
  lisPListType                  = 'Type';
  lisPListAll                   = '<All>';
  lisPListNone                  = '<None>';
  lisUIClearIncludedByReference = 'Clear include cache';
  lisChangeParent = 'Change Parent...';
  lisLazarusIDE = 'Lazarus IDE';
  lisDirectives = 'Directives';

  //conditional defines dialog
  rsCreateNewDefine = 'Create new define';
  rsConditionalDefines = 'Conditional defines';
  rsAddInverse = 'Add Inverse';
  rsRemove = '&Remove';
  lisAutomaticallyOnLineBreak = 'line break';
  lisAutomaticallyOnSpace = 'space';
  lisAutomaticallyOnWordEnd = 'word end';
  lisAutomaticallyRemoveCharacter = 'do not add character';
  lisPckOptsThisPackageProvidesTheSameAsTheFollowingPackages = 'This package '
    +'provides the same as the following packages:';
  lisPLDPackageLinks = 'Package Links';
  lisSAMOverrideFirstSelected = 'Override first selected';
  lisSAMOverrideAllSelected = 'Override all selected';
  lisCCDNoClass = 'no class';
  lisCCDChangeClassOf = 'Change Class of %s';

  // View Search Results dialog
  lisVSRForwardSearch = 'Forward Search';
  lisVSRResetResultList = 'Reset Result List';
  rsFoundButNotListedHere = 'Found, but not listed here: ';
  rsStartANewSearch = 'Start a new search';
  rsCloseCurrentPage = 'Close current page';
  rsFilterTheListWithTheCurrentFilterExpression = 'Filter the list with the '
    +'current filter expression';
  rsGoToTheNextItemInTheSearchList = 'Go to the next item in the search list';
  rsResetFilter = 'Reset filter';
  rsEnterOneOrMorePhrasesThatYouWantToSearchOrFilterIn = 'Enter one or more '
    +'phrases that you want to Search or Filter in the list, separated by '
    +'space, or comma';
  lisTDDInsertToDo = 'Insert ToDo';

  // Application Bundle
  lisABCreationFailed = 'Error occured during Application Bundle creation: ';
  lisUnableToWrite2 = 'Unable to write %s%s%s';
  lisErrorLoadingFrom = 'Error loading %s from%s%s%s%s';
  lisErrorSavingTo = 'Error saving %s to%s%s%s%s';
  lisXMLError = 'XML Error';
  lisXMLParserErrorInFileError = 'XML parser error in file %s%sError: %s';
  lisUnableToWriteXmlStreamToError = 'Unable to write xml stream to %s%'
    +'sError: %s';
  lisFileIsSymlink = 'File is symlink';
  lisTheFileIsASymlinkOpenInstead = 'The file %s%s%s is a symlink.%s%sOpen %s%'
    +'s%s instead?';
  lisOpenTarget = 'Open target';
  lisOpenSymlink = 'Open symlink';
  lisFileLinkError = 'File link error';
  lisWriteErrorFile = 'Write error: %s%sFile: %s%s%s';
  lisStreamError = 'Stream Error';
  lisUnableToUpdateTheBinaryResourceFileFromFileTheText = 'Unable to update '
    +'the binary resource file%s%s%sfrom file the text resource file%s%s%s%'
    +'sProbably the text file is corrupt.';
  lisTheCodetoolsFoundAnError = 'The codetools found an error:%s%s%s';
  lisIgnoreAndContinue = 'Ignore and continue';
  lisNotImplemented = 'Not implemented';
  lisNotImplementedYet = 'Not implemented yet:%s%s';
  lisOpenFile2 = 'Open File ...';
  lisMovePage = 'Move Page ...';
  lisFileSettings = 'File Settings ...';

  // Call Stack Dialog
  lisShow = 'Show';
  lisCurrent = 'Current';
  lisMaxS = 'Max %d';
  lisMore = 'More';
  lisTop = 'Top';
  lisBottom = 'Bottom';
  lisCopyAll = 'Copy All';
  lisIndex = 'Index';
  lisFunction = 'Function';

  // Break Points Dialog
  lisFilenameAddress = 'Filename/Address';
  lisLineLength = 'Line/Length';
  lisCondition = 'Condition';
  lisPassCount = 'Pass Count';
  lisGroup = 'Group';
  lisSourceBreakpoint = '&Source breakpoint';
  lisEnableAll = '&Enable All';
  lisDeleteAll = '&Delete All';
  lisDisableAllInSameSource = 'Disable All in same source';
  lisEnableAllInSameSource = 'Enable All in same source';
  lisDeleteAllInSameSource = 'Delete All in same source';
  lisNotImplementedYet2 = 'Not implemented yet.';
  lisDeleteAllSelectedBreakpoints = 'Delete all selected breakpoints?';
  lisDeleteBreakpointAtLine = 'Delete breakpoint at%s"%s" line %d?';
  lisDeleteAllBreakpoints = 'Delete all breakpoints?';
  lisDeleteAllBreakpoints2 = 'Delete all breakpoints in file %s%s%s?';
  lisBreak = 'Break';
  lisEnableGroup = 'Enable Group';
  lisDisableGroup = 'Disable Group';
  lisAutoContinue = 'Auto Continue';
  lisDisabled = 'Disabled';
  lisInvalidOff = 'Invalid (Off)';
  lisInvalidOn = 'Invalid (On)';
  lisOff = '? (Off)';
  lisOn = '? (On)';

  // Designer Size Components Dialog
  lisShrinkToSmal = 'Shrink to smallest';
  lisGrowToLarges = 'Grow to Largest';

  // Watch Property Dialog
  lisWatchPropert = 'Watch Properties';
  lisExpression = 'Expression:';
  lisRepeatCount = 'Repeat Count:';
  lisDigits = 'Digits:';
  lisAllowFunctio = 'Allow Function Calls';
  lisStyle = 'Style';
  lisCharacter = 'Character';
  lisString = 'String';
  lisDecimal = 'Decimal';
  lisHexadecimal = 'Hexadecimal';
  lisFloatingPoin = 'Floating Point';
  lisPointer = 'Pointer';
  lisRecordStruct = 'Record/Structure';
  lisMemoryDump = 'Memory Dump';

  // Locals Dialog
  lisLocals = 'Locals';
  lisLocalsDlgName = 'Name';
  lisLocalsDlgValue = 'Value';

  // Registers Dialog
  lisRegisters = 'Registers';
  lisRegistersDlgName = 'Name';
  lisRegistersDlgValue = 'Value';

  // Exception Dialog
  lisExceptionDialog = 'Debugger Exception Notification';
  lisBtnBreak = 'Break';
  lisBtnContinue = 'Continue';
  lisIgnoreExceptionType = 'Ignore this exception type';

  lisetEditCustomScanners = 'Edit custom scanners (%s)';
  
  // ProjectWizard Dialog
  lisPWNewProject = 'New Project';
  lisPWOpenProject = 'Open Project';
  lisPWRecentProjects  = 'Recent Projects';
  lisPWOpenRecentProject = 'Open Recent';
  lisPWConvertProject = 'Convert Delphi Project';
  lisInvalidCircle = 'Invalid circle';
  lisIsAThisCircleDependencyIsNotAllowed = '%s is a %s.%sThis circle '
    +'dependency is not allowed.';
  lisTheComponentCanNotBeDeletedBecauseItIsNotOwnedBy = 'The component %s can '
    +'not be deleted, because it is not owned by %s.';
  lisFilter2 = '(filter)';
  lisFindKeyCombination = 'Find key combination';
  lisInvalidPublishingDirectory = 'Invalid publishing Directory';
  lisSourceDirectoryAndDestinationDirectoryAreTheSameMa = 'Source directory %'
    +'s%s%s%sand destination directory %s%s%s%sare the same.%s%sMaybe you '
    +'misunderstand this feature.%sIt will clean/recreate the destination '
    +'directory%sand copies the package/project into it.';
  lisClearDirectory = 'Clear Directory?';
  lisInOrderToCreateACleanCopyOfTheProjectPackageAllFil = 'In order to create '
    +'a clean copy of the project/package, all files in the following '
    +'directory will be deleted and all its content will be lost.%s%sDelete '
    +'all files in %s%s%s?';
  lisFileExtensionOfPrograms = 'File extension of programs';
  lisEveryNThLineNumber = 'Every n-th line number:';
  lisLink = 'Link:';
  lisShort = 'Short:';
  lisDeleteOldFile2 = 'Delete old file?';
  lisTheUnitSearchPathOfContainsTheSourceDirectoryOfPac = 'The unit search '
    +'path of %s%s%s contains the source directory %s%s%s of package %s';
  lisFPCVersionEG222 = 'FPC Version (e.g. 2.2.2)';
  lisMissingIdentifiers = 'Missing identifiers';
  lisChooseAFPDocLink = 'Choose a FPDoc link';
  lisLinkTarget = 'Link target';
  lisExamplesIdentifierTMyEnumEnumUnitnameIdentifierPac = 'Examples:%'
    +'sIdentifier%sTMyEnum.Enum%sUnitname.Identifier%s#PackageName.UnitName.'
    +'Identifier';
  lisTitleLeaveEmptyForDefault = 'Title (leave empty for default)';
  lisSyntaxMode = 'Syntax mode';
  lisObjectPascalDefault = 'Object Pascal - default';
  lisDelphi = 'Delphi';
  lisTurboPascal = 'Turbo Pascal';
  lisMacPascal = 'Mac Pascal';
  lisFreePascal = 'Free Pascal';
  lisSmallerRatherThanFaster = 'smaller rather than faster';
  lisVerifyMethodCalls = 'Verify method calls';
  lisToggleShowingFilenamesWithFullPathOrWithRelativePa = 'Toggle showing '
    +'filenames with full path or with relative path';
  lisDeleteSelectedFiles = 'Delete selected files';
  lisAddDirectory = 'Add directory';
  lisAddFilesOfDirectory = 'Add files of directory';
  lisUnableToCreateLinkWithTarget = 'Unable to create link %s%s%s with '
    +'target %s%s%s';
  lisBuildAllFilesOfProjectPackageIDE =
    'build all files of project/package/IDE';
  lisApplyBuildFlagsBToDependenciesToo = 'apply build flags (-B) to '
    +'dependencies too';
  lisDoNotCompileDependencies = 'do not compile dependencies';
  lisBuildIDEWithPackages = 'build IDE with packages';
  lisShowVersionAndExit = 'show version and exit';
  lisOverrideTheProjectOperatingSystemEGWin32LinuxDefau = '%soverride the '
    +'project operating system. e.g. win32 linux. default: %s';
  lisOverrideTheProjectWidgetsetEGGtkGtk2QtWin32CarbonD = '%soverride the '
    +'project widgetset. e.g. gtk gtk2 qt win32 carbon. default: %s';
  lisOverrideTheProjectCpuEGI386X86_64PowerpcPowerpc_64 = '%soverride the '
    +'project cpu. e.g. i386 x86_64 powerpc powerpc_64 etc. default: %s';
  lisOverrideTheDefaultCompilerEGPpc386Ppcx64PpcppcEtcD = '%soverride the '
    +'default compiler. e.g. ppc386 ppcx64 ppcppc etc. default is stored in '
    +'environmentoptions.xml';
  lisNo = 'No';
  rsOk = 'ok';
  rsScanners = 'Scanners';
  rsAvailableScanners = 'Available scanners';
  rsSelectAnInheritedEntry = 'Select an inherited entry';

  // New console application dialog (CustomApplicationOptionsForm.pas)
  lisApplicationClassName = '&Application class name';
  lisTitle = '&Title';
  lisCodeGenerationOptions = 'Code generation options';
  lisUsageMessageHOption = 'Usage message (-h option)';
  lisStopOnException = 'Stop on exception';
  lisConstructorCode = 'Constructor code';
  lisDestructorCode = 'Destructor code';
  lisCheckOptions = 'Check options';
  lisNewConsoleApplication = 'New console application';

  // Edit context help dialog (IDEContextHelpEdit.pas)
  lisHelpEntries = 'Help entries';
  lisPath = 'Path';
  lisCEIsARootControl = 'Is a root control';
  lisHasHelp = 'Has Help';
  lisCreateHelpNode = 'Create Help node';
  lisEditContextHelp = 'Edit context help';
  lisNoNodeSelected = 'no node selected';
  lisNoIDEWindowSelected = 'No IDE window selected';

  // Messages Editor dialog (MsgViewEditor.pas)
  lisAddNewSet = 'Add new set';
  lisActiveFilter = 'Active Filter';
  lisFilterSets = 'Filter Sets';
  lisMessagesEditor = 'Messages Editor';

  // Additional Information dialog (VersionInfoAdditinalInfo.pas)
  lisComments = 'Comments:';
  lisAdditionalInformation = 'Additional Information';
  lisCompany = 'Company:';
  lisInternalName = 'Internal Name:';
  lisLegalTrademarks = 'Legal Trademarks:';
  lisOriginalFileName = 'Original File Name:';
  lisProductName = 'Product Name:';
  lisProductVersion = 'Product Version:';
  lisSetDefault = 'Set default';
  lisSelectedLeftNeighbour = '(selected left neighbour)';
  lisSelectedRightNeighbour = '(selected right neighbour)';
  lisSelectedTopNeighbour = '(selected top neighbour)';
  lisSelectedBottomNeighbour = '(selected bottom neighbour)';

  rsCreatingDirFailed = 'Creating directory "%s" failed!';
  rsCreatingSymLinkFailed = 'Creating symbolic link "%s" failed!';
  rsCreatingSymLinkNotSupported = 'Creating symbolic link is not supported on this platform!';
  lisPutLrsFilesInOutputDirectory = 'Save .lrs files in the output directory';
  dlgCOCreateNodeAbove = 'Create node above';
  dlgCOCreateNodeBelow = 'Create node below';
  dlgCOCreateChildNode = 'Create child node';
  lisResult = 'Result :=';
  lisPropertiesOfConditionalCompilerOption = 'Properties of conditional '
    +'compiler option';
  lisAction = 'Action:';
  lisValue = 'Value:';
  lisValues = 'Values';
  lisDefaultValue = 'Default value';
  lisConfirmDelete = 'Confirm delete';
  lisDeleteBuildMode = 'Delete build mode %s%s%s?';
  lisValue2 = 'Value%s';
  lisDeleteValue = 'Delete value %s%s%s';
  lisInvalidBuildModeTheBuildModeMustBeAPascalIdentifie = 'Invalid build '
    +'mode %s%s%s. The build mode must be a pascal identifier.';
  lisThereIsAlreadyABuildModeWithTheName = 'There is already a build mode '
    +'with the name %s%s%s.';  
  lisDuplicateFoundOfValue = 'Duplicate found of value %s%s%s.';  
  lisSetValue = 'Set value';
  lisCreateFunction = 'Create function';
  lisResult2 = 'Result:';
  lisTheIdentifierIsAUnitPleaseUseTheFileSaveAsFunction = 'The identifier is '
    +'a unit. Please use the File - Save as function to rename a unit.';
  lisUnusedUnits = 'Unused units';
  lisRemoveSelectedUnits = 'Remove selected units';
  lisRemoveAllUnits = 'Remove all units';
  lisCEShowCodeObserver = 'Show observerations about';
  lisCELongProcedures = 'Long procedures';
  lisCEManyParameters = 'Many parameters';
  lisCEUnnamedConstants = 'Unnamed constants';
  lisCEEmptyProcedures = 'Empty procedures';
  lisCEManyNestedProcedures = 'Many nested procedures';
  lisCEPublishedPropertyWithoutDefault = 'Published properties without default';
  lisCEUnsortedVisibility = 'Unsorted visibility';
  lisCEUnsortedMembers = 'Unsorted members';
  lisCEToDos = 'ToDos';
  lisCEEmptyClassSections = 'Empty class sections';
  lisCELongProcLineCount = 'Line count of procedure treated as "long"';
  lisCELongParamListCount = 'Parameters count treating as "many"';
  lisCENestedProcCount = 'Nested procedures count treating as "many"';
  lisCodeObsCharConst = 'Search for unnamed char constants';
  lisCodeObsIgnoreeConstants = 'Ignore next unnamed constants';
  lisCodeObIgnoreConstInFuncs = 'Ignore constants in next functions';
  lisCEEmptyBlocks = 'Empty blocks';
  lisCEComplexityGroup = 'Complexity';
  lisCEEmptyGroup = 'Empty constructs';
  lisCEStyleGroup = 'Style';
  lisCEOtherGroup = 'Other';
  lisCEWrongIndentation = 'Wrong indentation';
  lisTheProjectUsesTargetOSAndCPUTheSystemPpuForThisTar = 'The project uses '
    +'target OS=%s and CPU=%s.%sThe system.ppu for this target was not found '
    +'in the FPC binary directories. %sMake sure fpc is installed correctly '
    +'for this target and the fpc.cfg contains the right directories.';
  lisCouldNotRemoveFromMainSource = 'Could not remove %s%s%s from main source!';
  lisCouldNotAddToMainSource = 'Could not add %s%s%s to main source!';
  lisCouldNotRemoveRFromMainSource = 'Could not remove %s{$R %s%s} from main '
    +'source!';
  lisCouldNotAddRToMainSource = 'Could not add %s{$R %s%s} to main source!';
  lisCouldNotRemoveIFromMainSource = 'Could not remove %s{$I %s%s} from main '
    +'source!';
  lisCouldNotAddIToMainSource = 'Could not add %s{$I %s%s} to main source!';
  lisFailedToLoadFoldStat = 'Failed to load fold state';
  lisUppercaseString = 'uppercase string';
  lisUppercaseStringGivenAsParameter = 'Uppercase string given as parameter';
  lisLowercaseString = 'lowercase string';
  lisLowercaseStringGivenAsParameter = 'Lowercase string given as parameter';
  lisPasteClipboard = 'paste clipboard';
  lisPasteTextFromClipboard = 'Paste text from clipboard';
  lisInsertProcedureHead = 'insert procedure head';
  lisInsertProcedureName = 'insert procedure name';
  lisInsertNameOfCurrentProcedure = 'Insert name of current procedure';
  lisInsertDate = 'insert date';
  lisInsertDateOptionalFormatString = 'Insert date. Optional: format string';
  lisInsertTime = 'insert time';
  lisInsertTimeOptionalFormatString = 'Insert time. Optional: format string';
  lisInsertDateAndTime = 'insert date and time';
  lisInsertDateAndTimeOptionalFormatString = 'Insert date and time. Optional: '
    +'format string';
  lisInsertEndIfNeeded = 'insert end if needed';
  lisCheckIfTheNextTokenInSourceIsAnEndAndIfNotReturnsL = 'check if the next '
    +'token in source is an end and if not returns lineend + end; + lineend';
  lisListOfAllCaseValues = 'list of all case values';
  lisReturnsListOfAllValuesOfCaseVariableInFrontOfVaria = 'returns list of '
    +'all values of case variable in front of variable';
  lisGetWordAtCurrentCursorPosition = 'get word at current cursor position';
  lisTemplateEditParamCell = 'Editable Cell';
  lisTemplateEditParamCellHelp = 'Inserts an editable Cell, with a default value'
    + LineEnding + '"",Sync=n (,S=n), to Sync with a previous cell (n=1 to highest prev cell'
    + LineEnding + '"default",Sync, to Sync with a previous cell of equal default';
  lisPrecedingWord = 'Preceding word';

implementation

end.
