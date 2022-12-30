codeunit 50000 "Event Subscriptions"
{
    //PARA MOSTRAR EL PAGE ASSITED SETUP EN EL MANU DE ASSITED SETUP
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnRegisterAssistedSetup', '', true, true)]
    local procedure OnRegisterAssistedSetup()
    var
        AssistedSetup: Codeunit "Guided Experience";
        GuidedExperienceType: Enum "Guided Experience Type";
        AssistedSetupGroup: Enum "Assisted Setup Group";
        VideoCategory: Enum "Video Category";
    begin
        if not AssistedSetup.Exists(GuidedExperienceType::"Assisted Setup",
                                    ObjectType::Page,
                                    Page::"Producto Preferido - Setup") then
            AssistedSetup.InsertAssistedSetup(
                                             'Configura tu Producto Preferido',
                                             'Configura tu Producto Preferido',
                                             'Configura tu Producto Preferido',
                                             1,
                                             ObjectType::Page,
                                             Page::"Producto Preferido - Setup",
                                             AssistedSetupGroup::"App Producto Preferido",
                                             'https://www.youtube.com/watch?v=Zgycf_fcQ4s',
                                             VideoCategory::Extensions,
                                             'https://www.voxa.com.ar');
    end;

    //PARA NOTIFICAR AL USUARIO QUE PUEDE CONFIGURAR PRODUCTO PREFERIDO
    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnOpenPageEvent', '', true, true)]
    local procedure ShowNotification(var Rec: Record Customer)
    var
        Notificacion: Notification;
        MensajeNotificacion: label 'With Producto Preferido Extension you can add a Fav Item in this customer!',
                                Comment = 'ESP="Con la extensión Producto Preferido, ahora puedes añadir un producto preferido en este cliente!"';
        ActionNotificacion: label 'Show Assisted Setup',
                                Comment = 'ESP="Mostrar Configuración Asistida"';

    begin
        if HabilitarNotificacion() then begin
            Notificacion.Message(MensajeNotificacion);
            Notificacion.AddAction(ActionNotificacion, Codeunit::"Event Subscriptions", 'ShowHow');
            Notificacion.Send();
        end;


    end;

    local procedure HabilitarNotificacion(): Boolean
    var
        RecCustomer: Record Customer;
    begin
        RecCustomer.Reset();
        RecCustomer.SetFilter("Producto Preferido", '<>''''');
        if RecCustomer.Count < 10 then
            exit(true)
        else
            exit(false);
    end;

    //Función para 
    procedure ShowHow(Notificacion: Notification)
    var
        ProductoPreferidoSetup: Page "Producto Preferido - Setup";
    begin
        ProductoPreferidoSetup.Run();
    end;
}