package Service

import "onlineCustomerCare/entity"

// ServiceService specifies company service related service
type ServiceService interface {
	Services() ([]entity.Service, []error)
	Service(name string) (*entity.Service, []error)
	ServiceById(id int)(*entity.Service,[]error)
	UpdateService(service *entity.Service) (*entity.Service, []error)
	DeleteService(id int) (*entity.Service, []error)
	StoreService(service *entity.Service) (*entity.Service, []error)
}