package userRepository

import (
	"github.com/jinzhu/gorm"
	"onlineCustomerCare/entity"
	"onlineCustomerCare/user"
)

// UserGormRepo implements user.UserRepository interface
type UserGormRepo struct {
	conn *gorm.DB
}

// NewUserGormRepo returns new object of userGormRepo
func NewUserGormRepo(db *gorm.DB) user.UserRepository {
	return &UserGormRepo{conn: db}
}

// users returns all user stored in the database
func (userRepo *UserGormRepo) Users() ([]entity.User, []error) {
	var us []entity.User

	errs := userRepo.conn.Find(&us).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return us, errs
}

// User retrieves a user from the database by its id
func (userRepo *UserGormRepo) User(id int) (*entity.User, []error) {
	us := entity.User{}
	errs := userRepo.conn.Find(&us, id).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return &us, errs
}

// UpdateUser updates a given user in the database
func (userRepo *UserGormRepo) UpdateUser(user *entity.User) (*entity.User, []error) {
	us := user
	errs := userRepo.conn.Save(&us).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return us, errs
}

// DeleteUser deletes a given user from the database
func (userRepo *UserGormRepo) DeleteUser(id uint) (*entity.User, []error) {
	us, errs := userRepo.User(int(id))

	if len(errs) > 0 {
		return nil, errs
	}

	errs = userRepo.conn.Delete(&us, id).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return us, errs
}

// StoreUser stores a given user in the database
func (userRepo *UserGormRepo) StoreUser(user *entity.User) (*entity.User, []error) {
	us := user
	errs := userRepo.conn.Create(&us).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return us, errs
}

