use actix_web::{get, HttpResponse, Responder};

#[get("/health_check")]
pub async fn hlt_check() -> impl Responder {
    HttpResponse::Ok()
}
