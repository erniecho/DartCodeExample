
public class DataFileController {
    String mDef;
    String mWord;
    int mIndexLoc = 0;
    DataFile DataFileObject = new DataFile();
    Boolean SwitchBtn = true;
    int DataFileSizeLength = DataFileObject.WordDef.length; 

    public String getWord() {
        if (SwitchBtn == true) {
            this.mWord = DataFileObject.WordDef[mIndexLoc];
        } else {
            this.mWord = DataFileObject.ChineseWordDef[mIndexLoc];
        };
        return mWord;
    }

    public Boolean getSwitch() {
        return SwitchBtn;
    }

    public void setSwitch(boolean bb) {
        this.SwitchBtn = bb;
        if (this.SwitchBtn == true) {
            this.DataFileSizeLength = DataFileObject.WordDef.length;
        } else {
            this.DataFileSizeLength = DataFileObject.ChineseWordDef.length;
        };
    }

    public String getDef() {
        if (SwitchBtn == true) {
        mDef = DataFileObject.WordDef[mIndexLoc + 1];
    } else {
        mDef = DataFileObject.ChineseWordDef[mIndexLoc + 1];
    };
        return mDef;
    }

    public int getIndex() {
        return ((mIndexLoc / 2)+1);
    }

    public void setIndex(int sIndex) {
        if (sIndex > 0 || sIndex >= DataFileSizeLength) {
            this.mIndexLoc = sIndex;
        } else {
            this.mIndexLoc = 0;
        }
    }

    public void addIndex() {
        if (mIndexLoc < DataFileSizeLength && mIndexLoc >= 0) {
            this.mIndexLoc += 2;
        } else {
            this.mIndexLoc = 0;
        }
    }

    public void subIndex() {
        if (mIndexLoc > 0 || mIndexLoc >= DataFileSizeLength) {
            this.mIndexLoc -= 2;
        } else {
            this.mIndexLoc = 0;
        }
    }

    public void zeroIndex() {
        this.mIndexLoc = 0;
    }
}