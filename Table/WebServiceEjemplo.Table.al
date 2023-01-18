table 50000 "Ejemplo Web Service"
{
    Caption = 'WS Example', Comment = 'ESP="Ejemplo WebService"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Code[20])
        {

        }
        field(2; Nombre; Text[50])
        {

        }
    }

    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}