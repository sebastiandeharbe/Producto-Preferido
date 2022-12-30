page 50000 "Producto Preferido - Setup"
{
    PageType = NavigatePage;
    Caption = 'Producto Preferido - Setup';
    ApplicationArea = Suite;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group(MediaStandard)
            {
                Caption = '';
                Editable = false;
                Visible = (Step <> Step::Page3);
                field(MediaResourceStandard; MediaResourceStandard."Media Reference")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Editable = false;
                }
            }
            group(MediaDone)
            {
                Caption = '';
                Editable = false;
                Visible = (Step = Step::Page3);

                field(MediaResourceDone; MediaResourceDone."Media Reference")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Editable = false;
                }
            }

            //Cada grupo es un paso/subpagina
            group("PASO 1")
            {
                Visible = Page1Visible;
                InstructionalText = 'Welcome!',
                        Comment = 'ESP="Bienvenido! Ha instalado la extensión Producto Preferido. Con esta extensión usted puede configurar un producto preferido para cada cliente que tenga en su empresa.\ \"';
            }
            group("PASO 2")
            {
                Visible = Page2Visible;
                InstructionalText = 'Setup the Fav Item on Customer Card.\In the next field, choose a Customer and set a Fav Item for this.',
                        Comment = 'ESP="Configure el Producto Preferido en la ficha del cliente"';

                field("Customer"; RecCustomer."No.")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    TableRelation = Customer;

                    trigger OnValidate()
                    var
                        PageCustomer: Page "Customer Card";
                    begin
                        Clear(PageCustomer);
                        PageCustomer.SetTableView(RecCustomer);
                        PageCustomer.SetRecord(RecCustomer);
                        PageCustomer.LookupMode(true);
                        PageCustomer.Run();
                    end;
                }
                // field("item"; RecItem."No.")
                // {
                //     ApplicationArea = All;
                //     DrillDown = true;

                //     trigger OnValidate()
                //     begin
                //         RecCustomer."Producto Preferido" := RecItem."No.";
                //         RecCustomer.Modify();
                //     end;
                // }

            }
            group("FINAL")
            {
                Visible = Page3Visible;
                InstructionalText = 'Congratulations! You are finish the Fav Item Setup demo. Now you can add Fav Items in all yours customers.',
                        Comment = 'ESP="Felicitaciones! Terminaste la demo para configurar un Producto Preferido. Ahora puedes añadir Productos Preferidos para todos tus Clientes."';
            }
        }
    }
    //Botones de Previo, Siguiente y Finalizar -> SON ACCIONES
    actions
    {
        area(Processing)
        {
            action(PasoPrevio)
            {
                Caption = 'Back', Comment = 'ESP="Atrás"';
                ApplicationArea = All;
                Image = PreviousRecord;
                Enabled = (Page2Visible or Page3Visible);
                InFooterBar = true; //Para que la accion se muestre debajo de la page.

                trigger OnAction()
                begin
                    NextStep(true);
                end;
            }
            action(PasoSiguiente)
            {
                Caption = 'Next', Comment = 'ESP="Siguiente"';
                ApplicationArea = All;
                Image = NextRecord;
                Enabled = (Page1Visible or Page2Visible);
                InFooterBar = true;
                trigger OnAction()
                begin
                    NextStep(false);
                end;
            }
            action(Finalizar)
            {
                Caption = 'Finish', Comment = 'ESP="Finalizar"';
                ApplicationArea = All;
                Image = Approval;
                Enabled = Page3Visible;
                InFooterBar = true;

                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnInit()
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage()
    begin
        //al abrir la configuración, se debe mostrar el primer paso
        Step := Step::Page1;
        EnableVisibles();

        //Si la es el paso 2, cargar el item
        if Step = Step::Page2 then begin
            RecItem.Reset();
            RecItem.SetRange("No.", RecCustomer."No.");
        end;
    end;

    //funciones que sirven para controlar el valor de cada uno de los pasos
    local procedure NextStep(Backwards: Boolean)
    var
    begin
        if Backwards then
            Step -= 1 //retrocedo un paso
        else
            Step += 1; //avanzo un paso

        EnableVisibles();
    end;

    local procedure EnableVisibles()
    var
    begin
        //Reseteo los controles
        Page1Visible := false;
        Page2Visible := false;
        Page3Visible := false;

        //Dependiendo del paso, pongo visible la página correspondiente 
        case Step of
            Step::Page1:
                Page1Visible := true;
            Step::Page2:
                Page2Visible := true;
            Step::Page3:
                Page3Visible := true;
        end
    end;

    //Para cargar el banner de imagenes
    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType)) and
           MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType))
        then
            if MediaResourceStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
               MediaResourceDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourceDone."Media Reference".HasValue;
    end;

    var
        Step: Option Page1,Page2,Page3; //Variable para controlar el paso
        Page1Visible: Boolean; //Estas controlan la visibilidad del paso en el que me encuentro
        Page2Visible: Boolean;
        Page3Visible: Boolean;
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourceStandard: Record "Media Resources";
        MediaResourceDone: Record "Media Resources";
        TopBannerVisible: Boolean;
        RecCustomer: Record Customer;
        RecItem: Record Item;


}
