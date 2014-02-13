/**
 * Created by rachidcalazans on 2/12/14.
 */

// Mostrar msgs de error abaixo do input com id passado por parametro
function mostrar_menssagem_error(id ,msg) {
    var nova_msg = retira_caracteres_indesejados(msg);
    var msg = $(id).parent().append("<p class='p-erro'>"+nova_msg+"</p>");
    $(id).addClass("error-input");
}

// Retira caracteres indesejados nos campos de erros
function retira_caracteres_indesejados(msg){
    if (msg.indexOf("[&quot;") != -1 || msg.indexOf("&quot;]") != -1) {
        msg = msg.replace("[&quot;" , "").replace("&quot;]" ,"");
    }
    return msg;
}

function format_msgs(msg) {
    var msg_formated = '<p class="text-center">' + msg + '</p>';
    return msg_formated;
}
function show_msgs(msg, div_msg) {
    if (msg != "") {
        var msg_formated = format_msgs(msg);
        div_msg.html(msg_formated);
        div_msg.removeClass('hidden');
    }
}