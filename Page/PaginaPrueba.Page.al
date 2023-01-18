page 50001 "Pagina Prueba"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Ejemplo Web Service";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(WS; Rec.Id)
                {
                    ApplicationArea = All;
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Boton)
            {
                Caption = 'Botón Mágico';

                trigger OnAction()
                var
                    CuWS: Codeunit CallToWS;
                begin
                    CuWS.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}