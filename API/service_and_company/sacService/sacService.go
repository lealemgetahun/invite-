package sacService

import (
	"onlineCustomerCare/entity"
	"onlineCustomerCare/service_and_company"
)

type SacService struct {
	sacRepo service_and_company.SacRepository
}
func NewSacService(sacRepo service_and_company.SacRepository) service_and_company.SacService{
	return &SacService{sacRepo:sacRepo}
}
func (s SacService) SearchByService(id uint) ([]entity.Company_vs_service, []error) {
	comp, errs := s.sacRepo.SearchByService(id)
	if len(errs) > 0 {
		return nil, errs
	}
	return comp, errs
}

func (s SacService) SearchByCompany(id uint) ([]entity.Company_vs_service, []error) {
	comp, errs := s.sacRepo.SearchByCompany(id)
	if len(errs) > 0 {
		return nil, errs
	}
	return comp, errs
}

