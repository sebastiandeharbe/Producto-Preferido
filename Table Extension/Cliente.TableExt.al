tableextension 50000 "Cliente Extendido" extends Customer
{
    fields
    {
        field(50000; "Producto Preferido"; Code[20])
        {
            TableRelation = Item."No.";
            ValidateTableRelation = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Message('Este es un mensaje que rompe tus tests jeje');
            end;
        }
    }
}