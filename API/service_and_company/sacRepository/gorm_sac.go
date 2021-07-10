package sacRepository

import (
	"github.com/jinzhu/gorm"
	"onlineCustomerCare/entity"
	"onlineCustomerCare/service_and_company"
)

type sacGormRepo struct {
	conn *gorm.DB
}
func NewSacGormREpo(db *gorm.DB) service_and_company.SacRepository{
	return &sacGormRepo{conn:db}
}
func (s sacGormRepo) SearchByService(id uint) ([]entity.Company_vs_service, []error) {
	var comps []entity.Company_vs_service
	errs := s.conn.Where("Service_id = ?", id).Find(&comps).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return comps, errs
}

func (s sacGormRepo) SearchByCompany(id uint) ([]entity.Company_vs_service, []error) {
	var comps []entity.Company_vs_service
	errs := s.conn.Where("Company_id = ?", id).Find(&comps).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return comps, errs
}

