package service_and_company

import "onlineCustomerCare/entity"

type SacRepository interface {
	SearchByService(id uint) ([]entity.Company_vs_service, []error)
	SearchByCompany(id uint) ([]entity.Company_vs_service, []error)
}

