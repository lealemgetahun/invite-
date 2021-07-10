package commentRepository

import ("fmt"
		"github.com/jinzhu/gorm"
		"onlineCustomerCare/comment"
		"onlineCustomerCare/entity"
)

// CommentGormRepo implements menu.CommentRepository interface
type CommentGormRepo struct {
	conn *gorm.DB
}

// NewCommentGormRepo returns new object of CommentGormRepo
func NewCommentGormRepo(db *gorm.DB) comment.CommentRepository {
	return &CommentGormRepo{conn: db}
}

// Comments returns all customer comments stored in the database
func (cmntRepo *CommentGormRepo) Comments() ([]entity.Comment, []error) {
	var cmnts []entity.Comment
	fmt.Println(cmnts)
	errs := cmntRepo.conn.Find(&cmnts).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return cmnts, errs
}
// Comment retrieves a comment from the database by its id
func (cmntRepo *CommentGormRepo) Comment(id uint) (*entity.Comment, []error) {
	us := entity.Comment{}
	errs := cmntRepo.conn.Find(&us, id).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return &us, errs
}

// UpdateComment updates a given comment in the database
func (cmntRepo *CommentGormRepo) UpdateComment(comment *entity.Comment) (*entity.Comment, []error) {
	us := comment
	errs := cmntRepo.conn.Save(&us).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return us, errs
}

// DeleteComment deletes a given comment from the database
func (cmntRepo *CommentGormRepo) DeleteComment(id uint) (*entity.Comment, []error) {
	us, errs := cmntRepo.Comment(id)

	if len(errs) > 0 {
		return nil, errs
	}

	errs = cmntRepo.conn.Delete(&us, id).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return us, errs
}


// StoreComment stores a given customer comment in the database
func (cmntRepo *CommentGormRepo) StoreComment(comment *entity.Comment) (*entity.Comment, []error) {
	cmnt := comment
	errs := cmntRepo.conn.Create(cmnt).GetErrors()
	if len(errs) > 0 {
		return nil, errs
	}
	return cmnt, errs
}
