unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, Menus, uniMainMenu;

type
  TMainForm = class(TUniForm)
    UniMainMenu1: TUniMainMenu;
    masterdata1: TUniMenuItem;
    employee1: TUniMenuItem;
    procedure employee1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ListEmp;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.employee1Click(Sender: TObject);
begin
  UniForm1.ShowModal();
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
