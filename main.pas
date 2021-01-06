Program RandomSound;

Uses SysUtils;

Var Info : TSearchRec;
    Count : LongInt;
    ArrCount : LongInt;
    FilesArr : Array[0..999] of string;
    FileName : string;
    TrackedFile : Int64;
    FileId : Longint;
    RandomFileName : string;
    OutputFile : file of byte;
    f : file of byte;
    fContent: byte;

Begin
  Count:=0;
  ArrCount:=0;
  If FindFirst ('sounds/*',faAnyFile and faDirectory,Info)=0 then
    begin
    Repeat
      Inc(Count);
      With Info do
        begin
          FileName := Format('%s', [Name]);
          TrackedFile := (CompareText(FileName, '.') + CompareText(FileName, '..') + CompareText(FileName, '.gitignore'));
          If (TrackedFile > 2) then
          begin
            FilesArr[ArrCount] := Name;
            Inc(ArrCount);
          end
        end;
    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  
  Count:=0;
  assign(OutputFile, 'output.wav');
  randomize;

  begin
  Repeat
    FileId := random(ArrCount);
    RandomFileName := FilesArr[FileId];
    RandomFileName := ExpandFileName(IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + './sounds' + RandomFileName);
    Inc(Count);
    writeln(RandomFileName);
    assign(f, RandomFileName);
    Reset(f);
    Repeat
      begin
        read(f, fContent);
        write(OutputFile, fContent)
      end
    Until (eof(f));
    Close(f);
  Until (Count > 9);
  end;

  Close(OutputFile);
End.